-- Create the Cursors table
CREATE TABLE CURSORS (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Place VARCHAR(100)
);

-- Insert data into Cursors table
INSERT INTO Cursors (ID, Name, Place)
VALUES 
    (1, 'Panneer', 'Pondicherry'),
    (2, 'raja', 'chennai'),
    (3, 'guru', 'cuddalore');

--======================-Declare the variables for holding data========================
	
DECLARE @ID INT, @Name VARCHAR(100), @Place VARCHAR(100);
--Declare a cursor and Select Statement for where the loop start
DECLARE Product CURSOR 
FOR 
SELECT ID, Name, Place FROM CURSORS 
--Open cursor 
OPEN Product 

SELECT ID FROM CURSORS 
--Fetch the record from the select statement and assign into the 

FETCH NEXT FROM Product INTO 
@ID,
@Name,
@Place
-- Close and deallocate the cursor
CLOSE Product;
DEALLOCATE Product;

--======================-LOOP UNTIL RECORDS ARE AVAILABLE========================

-- Declare variables for cursor
DECLARE @ID INT, @Name VARCHAR(100), @Place VARCHAR(100);

-- Declare the cursor
DECLARE Product CURSOR FOR 
SELECT ID, Name, Place FROM CURSORS;

-- Open the cursor
OPEN Product;

-- Fetch the first row into variables
FETCH NEXT FROM Product INTO @ID, @Name, @Place;

-- Start the cursor loop
WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT * from CURSORS where ID =2
    -- Fetch the next row into variables
    FETCH NEXT FROM Product INTO @ID, @Name, @Place;
END

-- Close and deallocate the cursor
CLOSE Product;
DEALLOCATE Product;

--======================-Static Cursor holding data========================
DECLARE @ID VARCHAR(50), @Name VARCHAR(50), @Place VARCHAR(50)

DECLARE static_cursor CURSOR STATIC FOR
SELECT ID, Name, Place
FROM CURSORS;
OPEN static_cursor;

FETCH NEXT FROM static_cursor INTO @ID, @Name, @Place;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Process your data here
    -- For example, you can print the values
    PRINT CONCAT('ID: ', @ID, ', Name: ', @Name, ', Place: ', @Place);

    FETCH NEXT FROM static_cursor INTO @ID, @Name, @Place;
END

CLOSE static_cursor;
DEALLOCATE static_cursor;


--======================-Dynamic Cursor for looping========================
DECLARE @ID INT, @Name VARCHAR(50), @Place VARCHAR(50)
DECLARE @sql NVARCHAR(MAX)

-- Build the dynamic SQL statement
SET @sql = '
DECLARE @ID INT, @Name VARCHAR(50), @Place VARCHAR(50);
DECLARE dynamic_cursor CURSOR FOR
SELECT ID, Name, Place
FROM CURSORS;
OPEN dynamic_cursor;
FETCH NEXT FROM dynamic_cursor INTO @ID, @Name, @Place;
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Process your data here
    -- For example, you can print the values
    PRINT CONCAT(''ID: '', @ID, '', Name: '', @Name, '', Place: '', @Place);
    FETCH NEXT FROM dynamic_cursor INTO @ID, @Name, @Place;
END
CLOSE dynamic_cursor;
DEALLOCATE dynamic_cursor;
'

-- Execute the dynamic SQL
EXEC sp_executesql @sql;
