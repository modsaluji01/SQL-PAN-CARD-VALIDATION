# SQL-PAN-CARD-VALIDATION

## Project Overview

This project is based on validating PAN (Permanent Account Number) records using SQL. PAN is a critical identifier used in financial, banking, and government systems, so maintaining its accuracy is very important.

The purpose of this project is to check whether PAN numbers stored in a dataset follow the official format, identify invalid entries, and find duplicate records. The project highlights how SQL can be used effectively for data validation and data quality checks in real-world scenarios.

---

## Project Objectives

* To validate PAN numbers according to the standard format issued by the Income Tax Department of India
* To identify PAN records with incorrect length, wrong character patterns, or formatting errors
* To detect duplicate PAN numbers present in the dataset
* To demonstrate practical use of SQL for data validation and quality analysis

---

## PAN Number Validation Rules

A valid PAN number follows this structure:

* First 5 characters: Uppercase alphabets (A–Z)
* Next 4 characters: Numeric digits (0–9)
* Last character: Uppercase alphabet (A–Z)

**Example:** `ABCDE1234F`

Any PAN number that does not follow this pattern is treated as invalid.

---

## Dataset Description

The dataset contains PAN numbers collected across multiple records. It includes:

* Valid PAN numbers
* Invalid or incorrectly formatted PAN numbers
* Duplicate PAN entries

The data is provided in Excel format for easy understanding and review.

---

## Methodology

### Data Understanding

The dataset is examined to understand its structure and to identify issues such as missing values, incorrect PAN lengths, and duplicate entries.

### PAN Format Validation

SQL string functions and conditional logic are used to:

* Verify PAN length
* Check alphabetic and numeric positions
* Ensure characters are in uppercase

### Invalid PAN Detection

PAN numbers that fail any of the validation checks are flagged as invalid for further analysis.

### Duplicate PAN Detection

Duplicate PAN records are identified using `GROUP BY` and `HAVING` clauses to highlight repeated PAN numbers.

---

## SQL Concepts Used

* String functions
* CASE WHEN conditions
* Pattern matching
* Aggregate functions (COUNT)
* GROUP BY and HAVING clauses
* Data validation techniques

---

## Files Included in the Repository

* **PAN Number Validation – Problem Statement.pdf**
  Contains the project problem statement and requirements

* **PAN Number Validation Dataset.xlsx**
  Dataset used for validation and analysis

* **Pan Validation Project.sql**
  SQL script containing all validation queries

---

## Tools & Technologies

* SQL
* Microsoft SQL Server / MySQL
* Microsoft Excel

---

## Key Learnings

* Writing SQL queries for real-world data validation tasks
* Implementing pattern-based checks using SQL
* Identifying and handling duplicate records
* Understanding the role of data quality in analytics and reporting

---

## Conclusion

This project demonstrates how SQL can be used for more than just data retrieval. It shows how SQL can play an important role in validating data and maintaining data quality. Ensuring the accuracy of identifier fields like PAN numbers is essential in many data-driven systems, and this project provides a practical approach to achieving that.

---

## Author

**Mohammed**
