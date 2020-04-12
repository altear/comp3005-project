CREATE TABLE book (
    ISBN VARCHAR(13) PRIMARY KEY NOT NULL,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    genre TEXT,
    price MONEY NOT NULL,
    pages INT
);

CREATE TABLE address_book (
    ID SERIAL PRIMARY KEY,
    address_1 TEXT,
    address_2 TEXT,
    city TEXT,
    country TEXT,
    postal_code TEXT
);

CREATE TABLE contact_info (
    ID SERIAL PRIMARY KEY,
    address_id INT REFERENCES address_book (ID) NOT NULL,
    email TEXT,
    phone_number TEXT,
    name TEXT
);

CREATE TABLE publisher (
    ID SERIAL PRIMARY KEY,
    holder_name TEXT,
    financial_institute TEXT,
    branch_number TEXT, 
    transit_number TEXT,
    account_number TEXT,
    contact_id INT REFERENCES contact_info (ID) NOT NULL
);

CREATE TABLE pub_by (
    ISBN VARCHAR(13) PRIMARY KEY,
    publisher_id INT REFERENCES publisher (ID) NOT NULL,
    date DATE, 
    payment_percent REAL
);

CREATE TABLE cart (
    ID SERIAL PRIMARY KEY
);

CREATE TABLE payment_information (
    ID SERIAL PRIMARY KEY,
    holder_name TEXT,
    account_info TEXT
);

CREATE TABLE user_account (
    ID SERIAL PRIMARY KEY,
    is_admin BOOLEAN NOT NULL,
    username TEXT NOT NULL,
    password TEXT NOT NULL,
    contact_id INT REFERENCES contact_info (ID),
    shopping_cart INT REFERENCES cart (ID) NOT NULL,
    preferred_payment INT REFERENCES payment_information (ID) NOT NULL
); 

CREATE TABLE warehouse (
    ID SERIAL PRIMARY KEY,
    address_id INT REFERENCES address_book (ID) NOT NULL
);

CREATE TABLE stock (
    ISBN VARCHAR(13) PRIMARY KEY REFERENCES book (ISBN) NOT NULL,
    warehouse_id INT REFERENCES warehouse (ID) NOT NULL
);

CREATE TABLE cart_contents (
    cart_id INT REFERENCES cart (ID) NOT NULL,
    ISBN VARCHAR(13) REFERENCES book (ISBN) NOT NULL,
    quantity INT,
    PRIMARY KEY (cart_id, ISBN)
);

CREATE TABLE user_order (
    ID SERIAL PRIMARY KEY,
    shipping_address INT REFERENCES address_book (ID) NOT NULL,
    preferred_payment INT REFERENCES payment_information (ID) NOT NULL,
    cart_id INT REFERENCES cart (ID) NOT NULL,
    user_id INT REFERENCES user_account (ID) NOT NULL,
    payment_status TEXT
);

CREATE TABLE user_review (
    ISBN VARCHAR(13) REFERENCES book NOT NULL,
    user_id INT REFERENCES user_account (ID) NOT NULL,
    comment TEXT,
    rating int,
    date DATE,
    PRIMARY KEY (ISBN, user_id)
);