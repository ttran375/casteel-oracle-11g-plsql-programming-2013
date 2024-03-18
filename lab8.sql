-- Assignment 7-1: Creating a Package
-- Follow the steps to create a package containing a procedure and a function pertaining to basket
-- information. (Note: The first time you compile the package body doesn’t give you practice with
-- compilation error messages.)
-- 1. Start Notepad, and open the Assignment07-01.txt file in the Chapter07 folder.
-- 2. Review the package code, and then copy it.
-- 3. In SQL Developer, paste the copied code to build the package.
-- 4. Review the compilation errors and identify the related coding error.
-- 5. Edit the package to correct the error and compile the package.
CREATE OR REPLACE PACKAGE BODY order_info_pkg IS

  FUNCTION ship_name_pf (
    p_basket IN NUMBER
  ) RETURN VARCHAR2 IS
    lv_name_txt VARCHAR2(25);
  BEGIN
    SELECT
      shipfirstname
      ||' '
      ||shiplastname INTO lv_name_txt
    FROM
      bb_basket
    WHERE
      idBasket = p_basket;
    RETURN lv_name_txt;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 'Invalid basket id';
  END ship_name_pf;

  PROCEDURE basket_info_pp (
    p_basket IN NUMBER,
    p_shop OUT NUMBER,
    p_date OUT DATE
  ) IS
  BEGIN
    SELECT
      idshopper,
      dtordered INTO p_shop,
      p_date
    FROM
      bb_basket
    WHERE
      idbasket = p_basket;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      p_shop := NULL;
      p_date := NULL;
      RAISE_APPLICATION_ERROR(-20001, 'Invalid basket id');
  END basket_info_pp;
END;

-- Assignment 7-2: Using Program Units in a Package
-- In this assignment, you use program units in a package created to store basket information. The
-- package contains a function that returns the recipient’s name and a procedure that retrieves the
-- shopper ID and order date for a basket.
-- 1. In SQL Developer, create the ORDER_INFO_PKG package, using the
-- Assignment07-02.txt file in the Chapter07 folder. Review the code to become familiar
-- with the two program units in the package.
-- 2. Create an anonymous block that calls both the packaged procedure and function with
-- basket ID 12 to test these program units. Use DBMS_OUTPUT statements to display values
-- returned from the program units to verify the data.
-- 3. Also, test the packaged function by using it in a SELECT clause on the BB_BASKET table.
-- Use a WHERE clause to select only the basket 12 row.
-- Step 2: Anonymous block to test the package procedures and function
CREATE OR REPLACE PACKAGE order_info_pkg AS

  FUNCTION ship_name_pf(
    p_id IN NUMBER
  ) RETURN VARCHAR2;

  FUNCTION basket_info_pp(
    p_id IN NUMBER
  ) RETURN VARCHAR2;
END order_info_pkg;
/

CREATE OR REPLACE PACKAGE BODY order_info_pkg AS

  FUNCTION ship_name_pf(
    p_id IN NUMBER
  ) RETURN VARCHAR2 IS
  BEGIN
 -- Your implementation to fetch ship name based on p_id
    RETURN 'Sample Ship Name';
  END ship_name_pf;

  FUNCTION basket_info_pp(
    p_id IN NUMBER
  ) RETURN VARCHAR2 IS
  BEGIN
 -- Your implementation to fetch basket info based on p_id
    RETURN 'Sample Basket Info';
  END basket_info_pp;
END order_info_pkg;
/

DECLARE
  v_ship_name VARCHAR2(100);
BEGIN
  v_ship_name := order_info_pkg.ship_name_pf(12);
 -- Use v_ship_name as needed
  DBMS_OUTPUT.PUT_LINE('Ship Name: '
                       || v_ship_name);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: '
                         || SQLERRM);
END;
/

-- Assignment 7-3: Creating a Package with Private Program Units
-- In this assignment, you modify a package to make program units private. The Brewbean’s
-- programming group decided that the SHIP_NAME_PF function in the ORDER_INFO_PKG
-- package should be used only from inside the package. Follow these steps to make this
-- modification:
-- 1. In Notepad, open the Assignment07-03.txt file in the Chapter07 folder, and review the
-- package code.
-- 2. Modify the package code to add to the BASKET_INFO_PP procedure so that it also returns
-- the name an order is shipped by using the SHIP_NAME_PF function. Make the necessary
-- changes to make the SHIP_NAME_PF function private.
-- 3. Create the package by using the modified code.
-- 4. Create and run an anonymous block that calls the BASKET_INFO_PP procedure and
-- displays the shopper ID, order date, and shipped-to name to check the values returned.
-- Use DBMS_OUTPUT statements to display the values.
CREATE OR REPLACE PACKAGE order_info_pkg IS
 -- deleted function
  PROCEDURE basket_info_pp (
    p_basket IN NUMBER,
    p_shop OUT NUMBER,
    p_date OUT DATE,
    p_ship OUT VARCHAR
  ); -- added out variable
END;
/

CREATE OR REPLACE PACKAGE BODY order_info_pkg IS

  FUNCTION ship_name_pf (
    p_basket IN NUMBER
  ) RETURN VARCHAR2 IS
    lv_name_txt VARCHAR2(25);
  BEGIN
    SELECT
      shipfirstname
      ||' '
      ||shiplastname INTO lv_name_txt
    FROM
      bb_basket
    WHERE
      idBasket = p_basket;
    RETURN lv_name_txt;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Invalid basket id');
  END ship_name_pf;

  PROCEDURE basket_info_pp (
    p_basket IN NUMBER,
    p_shop OUT NUMBER,
    p_date OUT DATE,
    p_ship OUT VARCHAR
  ) -- added out variable
  IS
  BEGIN
    SELECT
      idshopper,
      dtordered INTO p_shop,
      p_date
    FROM
      bb_basket
    WHERE
      idbasket = p_basket;
    p_ship := ship_name_pf(p_basket); -- out variable used here
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Invalid basket id');
  END basket_info_pp;
END;
/

-- test procedure in block, this time I used basket
-- id 6, so we could actually see a name
DECLARE
  lv_id      NUMBER := 6;
  lv_name    VARCHAR2(25);
  lv_shopper bb_basket.idshopper%type;
  lv_date    bb_basket.dtcreated%type;
BEGIN
 -- test procedure
  order_info_pkg.basket_info_pp(lv_id, lv_shopper, lv_date, lv_name);
  dbms_output.put_line(lv_id
                       ||' '
                       ||lv_shopper
                       ||' '
                       ||lv_date
                       ||' '
                       ||lv_name);
END;
/

-- Assignment 7-4: Using Packaged Variables
-- In this assignment, you create a package that uses packaged variables to assist in the user
-- logon process. When a returning shopper logs on, the username and password entered need
-- to be verified against the database. In addition, two values need to be stored in packaged
-- variables for reference during the user session: the shopper ID and the first three digits of
-- the shopper’s zip code (used for regional advertisements displayed on the site).
-- 1. Create a function that accepts a username and password as arguments and verifies these
-- values against the database for a match. If a match is found, return the value Y. Set the
-- value of the variable holding the return value to N. Include a NO_DATA_FOUND exception
-- handler to display a message that the logon values are invalid.
-- 2. Use an anonymous block to test the procedure, using the username gma1 and the
-- password goofy.
-- 3. Now place the function in a package, and add code to create and populate the packaged
-- variables specified earlier. Name the package LOGIN_PKG.
-- 4. Use an anonymous block to test the packaged procedure, using the username gma1 and
-- the password goofy to verify that the procedure works correctly.
-- 5. Use DBMS_OUTPUT statements in an anonymous block to display the values stored in the
-- packaged variables.
-- create the function
CREATE OR REPLACE FUNCTION verify_user (
  usernm IN VARCHAR2,
  passwd IN VARCHAR2
) RETURN CHAR IS
  temp_user bb_shopper.username%type;
  confirm   CHAR(1) := 'N';
BEGIN -- if this select succeed, we can return Y
  SELECT
    username INTO temp_user
  FROM
    bb_shopper
  WHERE
    password = passwd;
  confirm := 'Y';
  RETURN confirm;
EXCEPTION -- if it fails, return N
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('logon values are invalid');
END;
/

-- test w/ host variables
variable g_ck char(1);

BEGIN
  :g_ck := verify_user('gma1', 'goofy');
END;
/

-- it worked!
print g_ck

/

-- make it a package this time
CREATE OR REPLACE PACKAGE login_pckg IS

  FUNCTION verify_user (
    usernm IN VARCHAR2,
    passwd IN VARCHAR2
  ) RETURN CHAR;
END;
/

-- body of the package
CREATE OR REPLACE PACKAGE BODY login_pckg IS

  FUNCTION verify_user (
    usernm IN VARCHAR2, -- everything in the function is the same
    passwd IN VARCHAR2
  ) RETURN CHAR IS
    temp_user bb_shopper.username%type;
    confirm   CHAR(1) := 'N';
  BEGIN
    SELECT
      username INTO temp_user
    FROM
      bb_shopper
    WHERE
      password = passwd;
    confirm := 'Y';
    RETURN confirm;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('logon values are invalid');
  END verify_user;
END;
/

-- host variable
variable g_ck char(1);

-- test, asignment and output in one block for convenience
BEGIN
  :g_ck := login_pckg.verify_user('gma1', 'goofy');
  dbms_output.put_line(:g_ck); -- it worked!
END;
/

-- Assignment 7-5: Overloading Packaged Procedures
-- In this assignment, you create packaged procedures to retrieve shopper information.
-- Brewbean’s is adding an application page where customer service agents can retrieve shopper
-- information by using shopper ID or last name. Create a package named SHOP_QUERY_PKG
-- containing overloaded procedures to perform these lookups. They should return the shopper’s
-- name, city, state, phone number, and e-mail address. Test the package twice. First, call the
-- procedure with shopper ID 23, and then call it with the last name Ratman. Both test values refer
-- to the same shopper, so they should return the same shopper information.
CREATE OR REPLACE PACKAGE shop_query_pkg IS
 -- first overloaded procedure, takes id
  PROCEDURE retrieve_shopper (
    lv_id IN bb_shopper.idshopper%type,
    lv_name OUT VARCHAR,
    lv_city OUT bb_shopper.city%type,
    lv_state OUT bb_shopper.state%type,
    lv_phone OUT bb_shopper.phone%type
  );
 -- second overloaded procedure, takes last name
  PROCEDURE retrieve_shopper (
    lv_last IN bb_shopper.lastname%type,
    lv_name OUT VARCHAR,
    lv_city OUT bb_shopper.city%type,
    lv_state OUT bb_shopper.state%type,
    lv_phone OUT bb_shopper.phone%type
  );
END;
/

CREATE OR REPLACE PACKAGE BODY shop_query_pkg IS
 -- first overloaded procedure, takes id
  PROCEDURE retrieve_shopper (
    lv_id IN bb_shopper.idshopper%type,
    lv_name OUT VARCHAR,
    lv_city OUT bb_shopper.city%type,
    lv_state OUT bb_shopper.state%type,
    lv_phone OUT bb_shopper.phone%type
  ) IS
  BEGIN -- this is almost the same as 7-1
    SELECT
      firstname
      ||' '
      ||lastname,
      city,
      state,
      phone INTO lv_name,
      lv_city,
      lv_state,
      lv_phone
    FROM
      bb_shopper
    WHERE
      idshopper = lv_id;
  END retrieve_shopper;
 -- second overloaded procedure, takes last name
  PROCEDURE retrieve_shopper (
    lv_last IN bb_shopper.lastname%type,
    lv_name OUT VARCHAR,
    lv_city OUT bb_shopper.city%type,
    lv_state OUT bb_shopper.state%type,
    lv_phone OUT bb_shopper.phone%type
  ) IS
  BEGIN -- again same as 7-1
    SELECT
      firstname
      ||' '
      ||lastname,
      city,
      state,
      phone INTO lv_name,
      lv_city,
      lv_state,
      lv_phone
    FROM
      bb_shopper
    WHERE
      lastname = lv_last;
  END retrieve_shopper;
END;
/

-- test procedure in block shopper id 23, Ratman
DECLARE
  lv_id    NUMBER := 23;
  lv_last  bb_shopper.lastname%type := 'Ratman';
  lv_name  VARCHAR2(25);
  lv_city  bb_shopper.city%type;
  lv_state bb_shopper.state%type;
  lv_phone bb_shopper.phone%type;
BEGIN
 -- test procedure w/ id
  shop_query_pkg.retrieve_shopper(lv_id, lv_name, lv_city, lv_state, lv_phone);
  dbms_output.put_line(lv_name
                       ||' '
                       ||lv_city
                       ||' '
                       ||lv_state
                       ||' '
                       ||lv_phone);
 -- test procedure w/ last name
  shop_query_pkg.retrieve_shopper(lv_last, lv_name, lv_city, lv_state, lv_phone);
  dbms_output.put_line(lv_name
                       ||' '
                       ||lv_city
                       ||' '
                       ||lv_state
                       ||' '
                       ||lv_phone);
END;
/

-- Assignment 7-6: Creating a Package with Only a Specification
-- In this assignment, you create a package consisting of only a specification. The Brewbean’s
-- lead programmer has noticed that only a few states require Internet sales tax, and the rates
-- don’t change often. Create a package named TAX_RATE_PKG to hold the following tax rates in
-- packaged variables for reference: pv_tax_nc = .035, pv_tax_tx = .05, and pv_tax_tn = .02.
-- Code the variables to prevent the rates from being modified. Use an anonymous block with
-- DBMS_OUTPUT statements to display the value of each packaged variable.
-- Assignment 7-7: Using a Cursor in a Package
-- In this assignment, you work with the sales tax computation because the Brewbean’s lead
-- programmer expects the rates and states applying the tax to undergo some changes. The tax
-- rates are currently stored in packaged variables but need to be more dynamic to handle the
-- expected changes. The lead programmer has asked you to develop a package that holds the
-- tax rates by state in a packaged cursor. The BB_TAX table is updated as needed to reflect
-- which states are applying sales tax and at what rates. This package should contain a function
-- that can receive a two-character state abbreviation (the shopper’s state) as an argument, and it
-- must be able to find a match in the cursor and return the correct tax rate. Use an anonymous
-- block to test the function with the state value NC.
-- Assignment 7-8: Using a One-Time-Only Procedure in a Package
-- The Brewbean’s application currently contains a package used in the shopper logon process.
-- However, one of the developers wants to be able to reference the time users log on to
-- determine when the session should be timed out and entries rolled back. Modify the
-- LOGIN_PKG package (in the Assignment07-08.txt file in the Chapter07 folder). Use a
-- one-time-only procedure to populate a packaged variable with the date and time of user
-- logons. Use an anonymous block to verify that the one-time-only procedure works and
-- populates the packaged variable.
-- Hands-On Assignments Part II
-- Assignment 7-9: Creating a Package for Pledges
-- Create a package named PLEDGE_PKG that includes two functions for determining dates of
-- pledge payments. Use or create the functions described in Chapter 6 for Assignments 6-12 and
-- 6-13, using the names DD_PAYDATE1_PF and DD_PAYEND_PF for these packaged functions.
-- Test both functions with a specific pledge ID, using an anonymous block. Then test both
-- functions in a single query showing all pledges and associated payment dates.
-- Assignment 7-10: Adding a Pledge Display Procedure to the Package
-- Modify the package created in Assignment 7-9 as follows:
-- • Add a procedure named DD_PLIST_PP that displays the donor name and all
-- associated pledges (including pledge ID, first payment due date, and last payment
-- due date). A donor ID is the input value for the procedure.
-- • Make the procedure public and the two functions private.
-- Test the procedure with an anonymous block.
-- Assignment 7-11: Adding a Payment Retrieval Procedure to the Package
-- Modify the package created in Assignment 7-10 as follows:
-- • Add a new procedure named DD_PAYS_PP that retrieves donor pledge payment
-- information and returns all the required data via a single parameter.
-- • A donor ID is the input for the procedure.
-- • The procedure should retrieve the donor’s last name and each pledge payment
-- made so far (including payment amount and payment date).
-- • Make the procedure public.
-- Test the procedure with an anonymous block. The procedure call must handle the data
-- being returned by means of a single parameter in the procedure. For each pledge payment,
-- make sure the pledge ID, donor’s last name, pledge payment amount, and pledge payment
-- date are displayed.
