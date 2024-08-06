# Library-Management-System-SQL

This project involves the design and implementation of a relational database system for a library, focusing on managing client information, book inventory, author details, and borrowing records. The database schema includes four primary tables: Clients, Authors, Books, and Borrowings. 

## Key features include:
1. Clients Table: 
Stores client details, including their first and last names, date of birth, and occupation.
2. Authors Table: 
Contains information about authors, including their names and nationalities.
3. Books Table: 
Records details about books, such as titles, associated author IDs, and genres. It includes a foreign key to link each book with its author.
4. Borrowings Table: 
Tracks borrowing transactions, including which client borrowed which book and on what date. It includes foreign keys to connect clients and books.

## Key Functionalities and Queries:
- Client and Borrowing Analytics: Queries to retrieve client details, borrowing patterns, and book popularity, including:
- Listing all clients and their details.
- Finding clients who borrowed books during specific periods.
- Determining the most and least borrowed authors and genres.
- Calculating average borrows per occupation and age.
- Identifying the oldest and youngest clients.

## Author Insights: 
Identifying authors who wrote books in multiple genres.

## Optimization: 
Index creation on frequently queried columns (e.g., genre, nationality, and borrowing date) to enhance query performance.

## Project Highlights:
- Comprehensive Data Management: The database efficiently manages detailed records of clients, authors, books, and borrowing activities.
- In-depth Analysis: Provides insightful queries to analyze borrowing trends, client demographics, and author contributions.
- Performance Optimization: Includes strategic indexing to improve the efficiency of data retrieval.
  
This project showcases the ability to design a structured database, write complex SQL queries for data analysis, and implement optimization techniques to ensure efficient data handling. It demonstrates proficiency in relational database management and serves as a robust foundation for managing library operations.
