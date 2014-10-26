PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE localUser(userID integer primary key,userName text);
CREATE TABLE localBook(bookID integer primary key,bookName text,bookValue integer);
CREATE TABLE localHistory(historyID integer primary key,userID integer,bookID integer,searchDate text);
CREATE TABLE bookAuthor(authorID integer primary key,authorName text);

COMMIT;
