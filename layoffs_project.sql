# DATA CLEANING & ANALYSIS PROJECT

SELECT * FROM layoffs;

# CREATE BACKUP TABLE
CREATE TABLE layoffs_project LIKE layoffs;

INSERT INTO layoffs_project
SELECT * FROM layoffs;

# REMOVE DUPLICATES
CREATE TABLE layoffs_project1 (
    company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off INT DEFAULT NULL,
    percentage_laid_off TEXT,
    `date` TEXT,
    stage TEXT,
    country TEXT,
    funds_raised_millions INT DEFAULT NULL,
    row_num INT
);

INSERT INTO layoffs_project1
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry,
total_laid_off, percentage_laid_off,
`date`, stage, country, funds_raised_millions
) AS row_num
FROM layoffs_project;

DELETE
FROM layoffs_project1
WHERE row_num > 1;

# STANDARDIZE DATA
UPDATE layoffs_project1
SET company = TRIM(company);

UPDATE layoffs_project1
SET industry = 'Crypto'
WHERE industry LIKE 'crypto%';

UPDATE layoffs_project1
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

# CHANGE DATE FORMAT
UPDATE layoffs_project1
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_project1
MODIFY COLUMN `date` DATE;

# HANDLE NULL VALUES
UPDATE layoffs_project1
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_project1 t1
JOIN layoffs_project1 t2
ON t1.company = t2.company
AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

# DROP HELPER COLUMN
ALTER TABLE layoffs_project1
DROP COLUMN row_num;

# DATA ANALYSIS

# Total layoffs
SELECT SUM(total_laid_off) AS total_layoffs
FROM layoffs_project1;

# Top 5 companies by layoffs
SELECT company,
SUM(total_laid_off) AS total_laid_off
FROM layoffs_project1
GROUP BY company
ORDER BY total_laid_off DESC
LIMIT 5;

# Layoffs by industry
SELECT industry,
SUM(total_laid_off) AS total_layoffs
FROM layoffs_project1
GROUP BY industry
ORDER BY total_layoffs DESC;

# Layoffs by country
SELECT country,
SUM(total_laid_off) AS total_layoffs
FROM layoffs_project1
GROUP BY country
ORDER BY total_layoffs DESC;

# Yearly layoffs trend
SELECT YEAR(`date`) AS year,
SUM(total_laid_off) AS total_layoffs
FROM layoffs_project1
GROUP BY year
ORDER BY year;

# Monthly rolling total
WITH monthly_layoffs AS (
SELECT DATE_FORMAT(`date`, '%Y-%m') AS month,
SUM(total_laid_off) AS total
FROM layoffs_project1
GROUP BY month
)

SELECT month,
total,
SUM(total) OVER(ORDER BY month) AS rolling_total
FROM monthly_layoffs;

# Rank companies by layoffs
SELECT company,
SUM(total_laid_off) AS total_laid_off,
DENSE_RANK() OVER(
ORDER BY SUM(total_laid_off) DESC
) AS ranking
FROM layoffs_project1
GROUP BY company;