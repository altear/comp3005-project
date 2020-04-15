-- Relation for storing books
CREATE TABLE book (
    ISBN VARCHAR(13) PRIMARY KEY NOT NULL,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    genre TEXT,
    price MONEY NOT NULL,
    pages INT
);

-- Relation for storing addresses
CREATE TABLE address_book (
    ID SERIAL PRIMARY KEY,
    address_1 TEXT,
    address_2 TEXT,
    city TEXT,
    country TEXT,
    postal_code TEXT
);

-- Relation for storing contact information
CREATE TABLE contact_info (
    ID SERIAL PRIMARY KEY,
    address_id INT REFERENCES address_book (ID),
    email TEXT,
    phone_number TEXT,
    name TEXT
);

-- Relation for storing publishers and their account numbers
CREATE TABLE publisher (
    ID SERIAL PRIMARY KEY,
    holder_name TEXT,
    financial_institute TEXT,
    branch_number TEXT, 
    transit_number TEXT,
    account_number TEXT,
    contact_id INT REFERENCES contact_info (ID) NOT NULL
);

-- Relation for storing who a book was published by
CREATE TABLE pub_by (
    ISBN VARCHAR(13) PRIMARY KEY,
    publisher_id INT REFERENCES publisher (ID) NOT NULL,
    date DATE, 
    payment_percent REAL
);

-- Relation for storing carts (carts keep track of items in orders or shopping carts)
CREATE TABLE cart (
    ID SERIAL PRIMARY KEY
);

-- Relation for saving customer payment information
CREATE TABLE payment_information (
    ID SERIAL PRIMARY KEY,
    holder_name TEXT,
    account_info TEXT
);

-- Relation for users (ie login information, contact, shopping cart, etc)
CREATE TABLE user_account (
    username TEXT PRIMARY KEY,
    password TEXT NOT NULL,
    is_admin BOOLEAN NOT NULL DEFAULT FALSE,
    contact_id INT REFERENCES contact_info (ID),
    shopping_cart INT REFERENCES cart (ID),
    preferred_payment INT REFERENCES payment_information (ID)
); 

-- Relation for warehouse
CREATE TABLE warehouse (
    ID SERIAL PRIMARY KEY,
    address_id INT REFERENCES address_book (ID) NOT NULL
);

-- Relation for showing the stock of books in warehouses
CREATE TABLE stock (
    ISBN VARCHAR(13) PRIMARY KEY REFERENCES book (ISBN) NOT NULL,
    warehouse_id INT REFERENCES warehouse (ID) NOT NULL
);

-- Relation for showing the contents of a cart
CREATE TABLE cart_contents (
    cart_id INT REFERENCES cart (ID) NOT NULL,
    ISBN VARCHAR(13) REFERENCES book (ISBN) NOT NULL,
    quantity INT,
    PRIMARY KEY (cart_id, ISBN)
);

-- Relation for showing a user's orders
CREATE TABLE user_order (
    ID SERIAL PRIMARY KEY,
    tracking_number TEXT NOT NULL,
    shipping_address INT REFERENCES address_book (ID) NOT NULL,
    preferred_payment INT REFERENCES payment_information (ID) NOT NULL,
    cart_id INT REFERENCES cart (ID) NOT NULL,
    owner TEXT REFERENCES user_account (username) NOT NULL,
    payment_status TEXT
);

-- Relation for showing a user's review of a book
CREATE TABLE user_review (
    ISBN VARCHAR(13) REFERENCES book NOT NULL,
    commenter TEXT REFERENCES user_account (username) NOT NULL,
    comment TEXT,
    rating int,
    date DATE,
    PRIMARY KEY (ISBN, commenter)
);

-- A view for more unified book information
CREATE VIEW book_details 
AS SELECT * FROM book
LEFT JOIN stock USING(ISBN)
LEFT JOIN pub_by USING(ISBN)
LEFT JOIN publisher ON pub_by.publisher_id=publisher.ID;


