-- Create the tables for the database, setting Primary Keys and conencting Foreign Keys

-- Create Clients table
CREATE TABLE Clients (
    ClientID INT PRIMARY KEY,
    ClientFirstName VARCHAR(50),
    ClientLastName VARCHAR(50),
    ClientDOB INT,
    Occupation VARCHAR(50));
    
-- Create Author table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorFirstName VARCHAR(50),
    AuthorLastName VARCHAR(50),
    AuthorNationality VARCHAR(50));    

-- Create Books table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    BookTitle VARCHAR(100),
    AuthorID INT,
    Genre VARCHAR(50),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID));
    
-- Create Borrowing table
CREATE TABLE Borrowings (
    BorrowingID INT PRIMARY KEY,
    ClientID INT,
    BookID INT,
    BorrowDate DATE,
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID));

-- Sample of code to populate tables 
INSERT INTO Clients (ClientID, ClientFirstName, ClientLastName, ClientDOB, Occupation) 
VALUES (1, "Kaiden", "Hill", 2006,	"Student"),
	(2,	"Alina", "Morton", 2010, "Student");
    
-- Queries to retrieve the information detailed below
-- 1. Display all contents of the Clients table
SELECT * 
FROM Clients;

-- 2. First names, last names, ages and occupations of all clients
SELECT ClientFirstName, ClientLastName, ClientDOD, Occupation 
FROM Clients;

-- 3. First and last names of clients that borrowed books in March 2018
SELECT c.ClientFirstName, c.ClientLastName
FROM Clients c
JOIN Borrowings b ON c.ClientID = b.ClientID
WHERE YEAR(b.BorrowDate) = 2018 AND MONTH(b.BorrowDate) = 3;

-- 4. First and last names of the top 5 authors clients borrowed in 2017
SELECT AuthorFirstName, AuthorLastName
FROM Authors a
JOIN Books b ON a.AuthorID = b.AuthorID
JOIN Borrowings bb ON bb.BookID = b.BookID
WHERE YEAR(bb.BorrowDate) = 2017
GROUP BY a.AuthorID
ORDER BY COUNT(b.BookID) DESC
LIMIT 5;

-- 5. Nationalities of the least 5 authors that clients borrowed during the years 2015-2017
SELECT a.AuthorNationality
FROM Authors a
JOIN Books b ON a.AuthorID = b.AuthorID
JOIN Borrowings bb ON bb.BookID = b.BookID
WHERE YEAR(BorrowDate) BETWEEN 2025 AND 2017
GROUP BY a.AuthorNationality
ORDER BY COUNT(b.BookID) ASC
LIMIT 5;

-- 6. The book that was most borrowed during the years 2015-2017
SELECT BookTitle
FROM Books b
JOIN Borrowings bb ON bb.BookID = b.BookID
WHERE YEAR(BorrowDate) BETWEEN 2015 AND 2017
GROUP BY b.BookID
ORDER BY COUNT(b.BookID) DESC
LIMIT 1;

-- 7. Top borrowed genres for client born in years 1970-1980
SELECT b.Genre, COUNT(BorrowingID) AS HowManyBorrowed
FROM Books b
JOIN Borrowings bb ON bb.BookID = b.BookID
JOIN Clients c ON c.ClientID = bb.ClientID
WHERE c.ClientDOB BETWEEN 1970 AND 1980
GROUP BY b.Genre
ORDER BY HowManyBorrowed DESC;

-- 8. Top 5 occupations that borrowed the most in 2016
SELECT c.Occupation
FROM Clients c
JOIN Borrowings bb ON c.ClientID = bb.ClientID
GROUP BY c.Occupations
ORDER BY COUNT(bb.BorrowingID) 
LIMIT 5;

-- 9. Average number of borrowed books by job title
SELECT c.Occupation, AVG(HowManyBorrowed) AS AverageBorrowed
FROM (SELECT Occupation, 
COUNT(BookID) AS HowManyBorrowed 
FROM Clients c 
JOIN Borrowings bb ON bb.ClientID = c.ClientID 
GROUP BY Occupation
) AS subq
GROUP BY Occupation;

-- 10. Create a VIEW and display the titles that were borrowed by at least 20% of clients 
CREATE VIEW MostViewed AS
SELECT b.BookTitle, COUNT(DISTINCT ClientID) AS HowManyClients
FROM Books b
JOIN Borrowings bb ON bb.BookID = b.BookID
JOIN Clients c ON c.ClientID = bb.ClientID
GROUP BY BookID 
HAVING HowManyClients >= 0.2

-- 11. The top month of borrows in 2017
SELECT MONTH(BorrowDate) AS BorrowMonth, COUNT(*) AS HowManyBorrowed
FROM Borrowings
WHERE YEAR(BorrowDate) = 2017
GROUP BY BorrowMonth
ORDER BY HowManyBorrowed DESC
LIMIT 1;

-- 12. Average number of borrows by age
SELECT AVG(HowManyBorrowed) AS AverageBorrowedByAge
FROM( 
	SELECT YEAR(CURRENT_DATE()) - ClientDOB AS Age, COUNT(*) As HowManyBorrowed 
    FROM Borrowings bb JOIN Client c ON bb.ClientID = c.ClientID 
    GROUP BY Age
    ) AS subq

-- 13. The oldest and the youngest clients of the library
SELECT ClientFirstName, ClientLastName, ClientDOB
FROM Clients
WHERE ClientDOB = (SELECT MIN(ClientDOB) FROM Clients)
   OR ClientDOB = (SELECT MAX(ClientDOB) FROM Clients);

-- 14. First and last names of authors that wrote books in more than one genre
SELECT DISTINCT a.AuthorFirstName, a.AuthorLastName
FROM Author a
JOIN Books b ON a.AuthorID = b.AuthorID
GROUP BY a.AuthorID
HAVING COUNT(DISTINCT Genre) > 1;

-- 15. Create Index that will increase query's performace
CREATE INDEX idxGenre ON Books(Genre);
CREATE INDEX idxNationality ON Authors(AuthorNationality);
CREATE INDEX idxBorrowDate ON Borrowings(BorrowDate);

    
    