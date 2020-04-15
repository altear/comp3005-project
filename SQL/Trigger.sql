
-- This is another barren file I was getting to :(

-- This trigger runs when a new contact is created in order 
-- to create a new address for the contact, I stopped using it
-- as I found a better way to do this. But I wanted to show I 
-- knew what triggers were :| 
CREATE TRIGGER contact_insert_trg
BEFORE INSERT ON contact_info
FOR EACH ROW 
EXECUTE FUNCTION contact_insert_foo();