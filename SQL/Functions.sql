-- helper function to add a new user 
CREATE FUNCTION add_user (
	_username TEXT, _password TEXT, _is_admin BOOLEAN,
	_address_1 TEXT, _address_2 TEXT, _city TEXT, _country TEXT, _postal_code TEXT,
	_email TEXT, _phone_number TEXT, _name TEXT
) RETURNS TEXT AS
$add_user$
DECLARE
	user_id INTEGER;
	address_id INTEGER;
	contact_id INTEGER;
	shopping_cart INTEGER;
	preferred_payment INTEGER;
BEGIN
	IF (SELECT count(*) FROM user_account WHERE user_account.username=_username) > 0 THEN
		RETURN NULL;
	END IF;
	
	-- create the address
	INSERT INTO address_book VALUES (DEFAULT, _address_1, _address_2, _city, _country, _postal_code) RETURNING ID INTO address_id;
	
	-- create the contact
	INSERT INTO contact_info VALUES (DEFAULT, address_id, _email, _phone_number, _name) RETURNING ID INTO contact_id;
	
	-- create the shopping cart
	INSERT INTO cart (ID) VALUES (DEFAULT) RETURNING ID INTO shopping_cart;
	
	-- create the payment information
	INSERT INTO payment_information (ID, holder_name, account_info) VALUES (DEFAULT, _name, 'Real credit info') RETURNING ID INTO preferred_payment;
	
	-- create the user
	INSERT INTO user_account (username, password, is_admin, contact_id, shopping_cart, preferred_payment) VALUES (_username, _password, _is_admin, contact_id, shopping_cart, preferred_payment);
	RETURN _username;
END;
$add_user$ LANGUAGE plpgsql;




-- A simple function for creating new contacts for users who do not have them
CREATE OR REPLACE FUNCTION contact_insert_foo() RETURNS trigger AS $contact_insert_foo$
BEGIN
	INSERT INTO address_book (ID) VALUES (DEFAULT) RETURNING ID INTO NEW.address_id;
	RETURN NEW;
END;
$contact_insert_foo$ LANGUAGE plpgsql;
