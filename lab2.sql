create DATABASE BookstoreDB;
GO

Use BookstoreDB;



create table Authors
(
    author_id int identity(1,1) primary key,-- identity i dont have to manually inserts IDS for primary keys
    first_name NVARCHAR(50) not null,
    last_name NVARCHAR(50) not null,
    birth_date date not null
);

create table Books
(
    ISBN13 CHAR (13) primary key,
    title NVARCHAR(255) not null,
    language NVARCHAR(50) not null,
    publication_date date not null,
    price decimal(10, 2) not null,
    desription NVARCHAR(max),
    publisher_id int not null,
    pages int not null,
    foreign key (publisher_id) references publishers(publisher_id)
);

-- make a junction for book and authors because one book can have multiple authors and one author can write multiple books
CREATE TABLE book_authors (
    isbn13 CHAR(13) NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (isbn13, author_id),
    FOREIGN KEY (isbn13) REFERENCES books(isbn13),
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);


create table publishers
(
    publisher_id int primary key,
    publisher_name NVARCHAR(100) not null,
    country NVARCHAR(50) not null
);