-- This barren file is where my queries would have gone
-- If only I had more time/less courses/better time management


-- Simple query to get users for login
SELECT * FROM user_account
WHERE username=%s AND password=%s;
-- note this won't run because %s is for run-time substitutions

-- Simple query to get books 
SELECT * FROM book_details; 