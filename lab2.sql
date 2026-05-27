create DATABASE BookstoreDB;
GO

Use BookstoreDB;


--(VG) I put publisher first because book has a foreign key to publisher, so I need to create publisher table first
CREATE TABLE publishers (
    publisher_id INT IDENTITY(1,1) PRIMARY KEY,
    publisher_name NVARCHAR(100) NOT NULL,
    country NVARCHAR(100)
);


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



CREATE TABLE stores (
    store_id INT IDENTITY(1,1) PRIMARY KEY,
    store_name NVARCHAR(100) NOT NULL,
    address NVARCHAR(200),
    city NVARCHAR(100),
    country NVARCHAR(100)
);

-- many to many
CREATE TABLE inventory_balance (
    store_id INT NOT NULL,
    isbn13 CHAR(13) NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    PRIMARY KEY (store_id, isbn13),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (isbn13) REFERENCES books(isbn13)
);


--(VG)
--(many to many relationship) make a junction for book and authors because one book can have multiple authors and one author can write multiple books
CREATE TABLE book_authors (
    isbn13 CHAR(13) NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (isbn13, author_id),
    FOREIGN KEY (isbn13) REFERENCES books(isbn13),
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);
--(VG)

CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) UNIQUE,
    phone NVARCHAR(20)
);

--(VG)

CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    store_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);
--(VG)
CREATE TABLE order_items (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    isbn13 CHAR(13) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (isbn13) REFERENCES books(isbn13)
);


-- make the data for tables:
INSERT INTO publishers (publisher_name, country) VALUES
('Penguin Books', 'UK'),
('HarperCollins', 'USA'),
('Norstedts', 'Sweden'),
('Bonnier Carlsen', 'Sweden');


insert into Authors (first_name, last_name, birth_date) values
('J.K.', 'Rowling', '1965-07-31'),
('George', 'Orwell', '1903-06-25'),
('Jane', 'Austen', '1775-12-16'),
('Agatha', 'Christie', '1890-09-15');

INSERT INTO books (ISBN13, title, language, publication_date, price, desription, publisher_id, pages) VALUES
('9780140449136', 'The Odyssey', 'English', '2003-01-01', 129.00, 'Classic Greek epic.', 1, 560),
('9780307474278', 'The Road', 'English', '2006-09-26', 159.00, 'Post-apocalyptic novel.', 2, 320),
('9780061120084', 'To Kill a Mockingbird', 'English', '2002-07-05', 149.00, 'American classic.', 2, 336),
('9781501128035', 'It Ends With Us', 'English', '2016-08-02', 199.00, 'Romantic drama.', 2, 384),
('9780590353427', 'Harry Potter and the Sorcerer''s Stone', 'English', '1997-06-26', 129.00, 'Fantasy novel.', 1, 309),
('9789127161234', 'Svenska Hjältar', 'Swedish', '2019-03-15', 189.00, 'Swedish stories.', 3, 250),
('9789178031231', 'Mysteriet i Skogen', 'Swedish', '2020-05-10', 149.00, 'Children''s mystery.', 4, 180),
('9789174291234', 'Nordiska Myter', 'Swedish', '2018-11-01', 199.00, 'Nordic mythology.', 3, 400),
('9780143127796', 'Educated', 'English', '2018-02-20', 179.00, 'Memoir.', 1, 352),
('9780062315007', 'The Alchemist', 'English', '2014-04-15', 139.00, 'Philosophical novel.', 2, 208);


INSERT INTO stores (store_name, address, city, country) VALUES
('Göteborg City Books', 'Avenyn 12', 'Göteborg', 'Sweden'),
('Stockholm Central Books', 'Drottninggatan 55', 'Stockholm', 'Sweden'),
('Malmö Book House', 'Stortorget 3', 'Malmö', 'Sweden');


INSERT INTO inventory_balance (store_id, isbn13, quantity) VALUES
(1, '9780590353427', 12),
(1, '9780307474278', 5),
(1, '9780140449136', 3),

(2, '9780061120084', 7),
(2, '9781501128035', 10),
(2, '9780143127796', 4),

(3, '9789178031231', 8),
(3, '9789174291234', 6),
(3, '9780062315007', 9);


INSERT INTO book_authors (isbn13, author_id) VALUES
('9780140449136', 2),
('9780307474278', 2),
('9780061120084', 4),
('9781501128035', 3),
('9780590353427', 1),
('9789127161234', 1),
('9789178031231', 3),
('9789174291234', 3),
('9780143127796', 4),
('9780062315007', 4);


INSERT INTO customers (first_name, last_name, email, phone) VALUES
('Anna', 'Svensson', 'anna@example.com', '0701234567'),
('Mark', 'Johansson', 'mark@example.com', '0709876543'),
('Sara', 'Nilsson', 'sara@example.com', '0705551234'),
('David', 'Karlsson', 'david@example.com', '0704449876'),
('Emma', 'Larsson', 'emma@example.com', '0703332221');

insert into orders (customer_id, store_id, order_date) values
(1, 1, '2023-01-01'),
(2, 2, '2023-01-02'),
(3, 3, '2023-01-03'),
(4, 1, '2023-01-04'),
(5, 2, '2023-01-05');

INSERT INTO order_items (order_id, isbn13, quantity, unit_price) VALUES
(1, '9780590353427', 1, 129.00),
(1, '9780140449136', 1, 129.00),

(2, '9781501128035', 2, 199.00),

(3, '9780307474278', 1, 159.00),

(4, '9789178031231', 3, 149.00),

(5, '9780062315007', 1, 139.00);

GO

-- I create views on single batches othevise get error
-- make views to make the tables simpler to read and understand:
CREATE VIEW view_books_with_publishers AS
SELECT 
    books.ISBN13,
    books.title,
    books.language,
    books.publication_date,
    books.price,
    books.desription,
    books.pages,
    publishers.publisher_name,
    publishers.country AS publisher_country
FROM books
JOIN publishers ON books.publisher_id = publishers.publisher_id;
GO


CREATE VIEW view_books_with_authors AS
SELECT 
    books.ISBN13,
    books.title,
    authors.author_id,
    authors.first_name,
    authors.last_name
FROM books
JOIN book_authors ON books.ISBN13 = book_authors.isbn13
JOIN authors ON book_authors.author_id = authors.author_id;
GO


CREATE VIEW view_store_inventory AS
SELECT 
    stores.store_id,
    stores.store_name,
    books.ISBN13,
    books.title,
    inventory_balance.quantity
FROM inventory_balance
JOIN stores ON inventory_balance.store_id = stores.store_id
JOIN books ON inventory_balance.isbn13 = books.ISBN13;
GO


CREATE VIEW view_orders_with_customers AS
SELECT 
    orders.order_id,
    orders.order_date,
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customers.email,
    orders.store_id
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id;
GO


CREATE VIEW view_order_details AS
SELECT 
    orders.order_id,
    orders.order_date,
    customers.first_name AS customer_first_name,
    customers.last_name AS customer_last_name,
    order_items.order_item_id,
    order_items.quantity,
    order_items.unit_price,
    books.ISBN13,
    books.title
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN order_items ON orders.order_id = order_items.order_id
JOIN books ON order_items.isbn13 = books.ISBN13;
GO


-- (VG) i create the store procedure

CREATE PROCEDURE MoveBook
    @isbn13 CHAR(13),
    @from_store_id INT,
    @to_store_id INT,
    @quantity INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the source store has the book
    IF NOT EXISTS (
        SELECT 1 
        FROM inventory_balance
        WHERE store_id = @from_store_id
          AND isbn13 = @isbn13
    )
    BEGIN
        PRINT 'Source store does not have this book.';
        RETURN;
    END

    -- Check if the source store has enough quantity
    IF (SELECT quantity 
        FROM inventory_balance
        WHERE store_id = @from_store_id
          AND isbn13 = @isbn13) < @quantity
    BEGIN
        PRINT 'Not enough quantity in source store.';
        RETURN;
    END

    -- Subtract quantity from source store
    UPDATE inventory_balance
    SET quantity = quantity - @quantity
    WHERE store_id = @from_store_id
      AND isbn13 = @isbn13;

    -- If destination store does not have the book, insert it
    IF NOT EXISTS (
        SELECT 1 
        FROM inventory_balance
        WHERE store_id = @to_store_id
          AND isbn13 = @isbn13
    )
    BEGIN
        INSERT INTO inventory_balance (store_id, isbn13, quantity)
        VALUES (@to_store_id, @isbn13, @quantity);

        PRINT 'Book moved successfully (new entry created).';
        RETURN;
    END

    -- Otherwise, update destination store quantity
    UPDATE inventory_balance
    SET quantity = quantity + @quantity
    WHERE store_id = @to_store_id
      AND isbn13 = @isbn13;

    PRINT 'Book moved successfully.';
END;
GO

EXEC MoveBook '9780590353427', 1, 2, 2;

SELECT *
FROM inventory_balance
WHERE isbn13 = '9780590353427';
