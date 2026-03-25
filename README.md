MochiVocab: Data-Driven Vocabulary Application

Project Overview
A conceptualized vocabulary learning application built on a normalized relational database (3NF). This project focuses on the backend data architecture required to power a **Spaced Repetition (Golden Time)** engine, ensuring optimal user retention and scalable data management.

Database Architecture (ERD)
![MochiVocab ERD](./docs/Mochi_ERD.png)

> **Tech Stack:** Microsoft SQL Server (T-SQL) | **Design:** 3rd Normal Form (3NF)

The schema utilizes a central junction table (`User_Vocab_Tracking`) to handle the N-N relationship between Users and Vocabularies, isolating the spaced repetition variables from static dictionary data.

📂 Repository Structure
📁 **`/sql_scripts/`**
  * `01_Mochi_SQL_Server_Schema.sql` - DDL script to initialize the 7 core tables.
  * `02_Mochi_Mock_Data.sql` - *(Coming soon - Day 2)* DML script to populate test data.
  * `03_Spaced_Repetition_Queries.sql` - *(Coming soon - Day 2)* Core algorithm query logic.
📁 **`/docs/`**
  * `UC001_Review_At_Golden_Time.pdf` - Functional specifications & Data requirements.
  * `Mochi_ERD.png` - Database schema diagram.

 Core Modules & Business Logic

Module 1: Spaced Repetition Engine (UC001)
- **Trigger:** Filters `next_review_time <= NOW()`
- **Data Logic:** Executes `UPDATE` on the junction table (`User_Vocab_Tracking`) to dynamically overwrite `memory_level` and calculate the next review interval based on user performance.

Module 2: Course Management (UC002, UC003)
- *(Work in Progress)* - Enrolling users, tracking course progress, and mapping vocabularies to specific courses.

Module 3: User Profiles & Authentication (UC004, UC005)
- *(Work in Progress)* - Handling free/premium access tiers and user preferences.
