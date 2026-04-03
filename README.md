MochiVocab: Data-Driven Vocabulary Application

Project Overview
A conceptualized vocabulary learning application built on a normalized relational database (3NF). This project focuses on the backend data architecture required to power a **Spaced Repetition (Golden Time)** engine, ensuring optimal user retention and scalable data management.

Database Architecture (ERD)
![MochiVocab ERD](./docs/ERD%20Mochi.png)

> **Tech Stack:** Microsoft SQL Server (T-SQL) | **Design:** 3rd Normal Form (3NF)

The schema utilizes a central junction table (`User_Vocab_Tracking`) to handle the N-N relationship between Users and Vocabularies, isolating the spaced repetition variables from static dictionary data.

## 📂 Repository Structure
* 📁 **`/sql_scripts/`**
  * `01_Mochi_SQL_Server_Schema.sql` - DDL script to initialize the 7 core tables.
  * `02_Mochi_Mock_Data.sql` - *(Coming soon - Day 2)* DML script to populate test data.
  * `03_Spaced_Repetition_Queries.sql` - *(Coming soon - Day 2)* Core algorithm query logic.
* 📁 **`/docs/`**
  * `UC1.docx.pdf` - Functional specifications & Data requirements.
  * `ERD Mochi.png` - Database schema diagram.

Core Modules & Business Logic

Module 1: Spaced Repetition Engine (UC001)
- **Trigger:** Filters `next_review_time <= NOW()`
- **Data Logic:** Executes `UPDATE` on the junction table (`User_Vocab_Tracking`) to dynamically overwrite `memory_level` and calculate the next review interval based on user performance.

Module 2: Course & Learning Progress (UC003, UC004)
* **Enrollment Logic:** Utilizes the `User_Course` junction table to resolve the N-N relationship between Users and Courses, isolating progress tracking from static user data.
* **Progress Tracking:** `progress_percentage` is dynamically calculated based on the ratio of mastered words (`memory_level = 5` in `User_Vocab_Tracking`) to total course words.
* **Trigger:** Completing a learning session automatically executes an `INSERT/UPDATE` to initiate the first Golden Time schedule.

Module 3: System Config & Personal Dictionary (UC002, UC005)
* **Data Validation (Duplicate Check):** When saving a new word, the system queries the composite key (`user_id`, `vocab_id`) in `User_Vocab_Tracking` to prevent duplicate insertions and preserve existing review schedules.
* **Separation of Concerns:** UI/UX settings (Dark Mode, Language, Sound) are strictly separated into the `User_Preferences` table (1-1 relationship). This optimizes payload size by preventing the system from fetching redundant configuration data during basic authentication queries.
