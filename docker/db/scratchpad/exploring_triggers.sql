
CREATE OR REPLACE FUNCTION foo() RETURNS trigger AS $foo$
BEGIN
	-- create new cart
	INSERT INTO cart (ID) VALUES (DEFAULT) RETURNING ID INTO NEW.shopping_cart;
	
	-- create new contact info
	INSERT INTO contact_info (ID) VALUES (DEFAULT) RETURNING ID INTO NEW.contact_id;
	
	-- create new payment info
	INSERT INTO payment_information (ID) VALUES (DEFAULT) RETURNING ID INTO NEW.preferred_payment;
	RETURN NEW;
END;
$foo$ LANGUAGE plpgsql;

-- CREATE TRIGGER on_user_create 
-- BEFORE INSERT ON user_account
-- FOR EACH ROW 
-- EXECUTE FUNCTION foo();

CREATE OR REPLACE FUNCTION contact_insert_foo() RETURNS trigger AS $contact_insert_foo$
BEGIN
	-- create and return a new address book
	INSERT INTO address_book (ID) VALUES (DEFAULT) RETURNING ID INTO NEW.address_id;
	RETURN NEW;
END;
$contact_insert_foo$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS contact_insert_trg ON contact_info;
CREATE TRIGGER contact_insert_trg
BEFORE INSERT ON contact_info
FOR EACH ROW 
EXECUTE FUNCTION contact_insert_foo();
-- CREATE TABLE user_account (
--     ID SERIAL PRIMARY KEY,
--     is_admin BOOLEAN NOT NULL,
--     username TEXT NOT NULL,
--     password TEXT NOT NULL,
--     contact_id INT REFERENCES contact_info (ID),
--     shopping_cart INT REFERENCES cart (ID),
--     preferred_payment INT REFERENCES payment_information (ID)
-- ); 

-- CREATE TABLE test (
-- 	ID BOOLEAN NOT NULL DEFAULT FALSE
-- );
INSERT INTO user_account (is_admin, username, password) VALUES (FALSE, 'test', 'test');

SELECT * FROM user_account;