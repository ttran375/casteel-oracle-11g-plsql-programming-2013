-- Assignment 2-1: Using Scalar Variables
-- Create a PL/SQL block containing the following variables: Name Data Type Option Initial Value lv_test_date DATE December 10, 2012 lv_test_num NUMBER(3) CONSTANT 10 lv_test_txt VARCHAR2(10) Assign your last name as the value of the text variable in the executable section of the block. Include statements in the block to display each variable’s value onscreen.
DECLARE
    LV_TEST_DATE DATE := TO_DATE('10-DEC-2012', 'DD-MON-YYYY');
    LV_TEST_NUM  CONSTANT NUMBER(3) := 10;
    LV_TEST_TXT  VARCHAR2(10);
BEGIN
    LV_TEST_TXT := 'Copilot'; -- Assigning the last name
    DBMS_OUTPUT.PUT_LINE('Date: '
                         || TO_CHAR(LV_TEST_DATE, 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('Number: '
                         || LV_TEST_NUM);
    DBMS_OUTPUT.PUT_LINE('Text: '
                         || LV_TEST_TXT);
END;
/

-- Assignment 2-2: Creating a Flowchart The Brewbean’s application needs a block that determines whether a customer is rated high, mid, or low based on his or her total purchases. The block needs to determine the rating and then display the results onscreen. The code rates the customer high if total purchases are greater than $200, mid if greater than $100, and low if $100 or lower. Develop a flowchart to outline the conditional processing steps needed for this block.
-- Start
-- |
-- v
-- [Declare TOTAL_PURCHASES, HIGH_LIMIT, MID_LIMIT]
-- |
-- v
-- [Initialize TOTAL_PURCHASES to 150]
-- |
-- v
-- [Display "Enter Total Purchases: 150"]
-- |
-- v
-- [Check if TOTAL_PURCHASES > HIGH_LIMIT]
-- |
-- v
-- |-----[True]
-- |       |
-- |       v
-- |       [Display "Customer Rated High"]
-- |       |
-- |       v
-- |       [Display "High Rating"]
-- |       |
-- |       v
-- |       [Display "End of Flowchart"]
-- |
-- |-----[False]
-- |       |
-- |       v
-- |       [Check if TOTAL_PURCHASES > MID_LIMIT]
-- |       |
-- |       v
-- |       |-----[True]
-- |       |       |
-- |       |       v
-- |       |       [Display "Customer Rated Mid"]
-- |       |       |
-- |       |       v
-- |       |       [Display "Mid Rating"]
-- |       |       |
-- |       |       v
-- |       |       [Display "End of Flowchart"]
-- |       |
-- |       |-----[False]
-- |               |
-- |               v
-- |               [Display "Customer Rated Low"]
-- |               |
-- |               v
-- |               [Display "Low Rating"]
-- |               |
-- |               v
-- |               [Display "End of Flowchart"]
-- |
-- v
-- [End]


-- Assignment 2-3: Using IF Statements
-- Create a block using an IF statement to perform the actions described in Assignment 2-2. Use a scalar variable for the total purchase amount, and initialize this variable to different values to test your block.
DECLARE
    TOTAL_PURCHASES NUMBER := 150; -- Initialize total purchases to test the block
    HIGH_LIMIT      NUMBER := 200;
    MID_LIMIT       NUMBER := 100;
BEGIN
 -- Enter Total Purchases
    DBMS_OUTPUT.PUT_LINE('Enter Total Purchases: '
                         || TOTAL_PURCHASES);
 -- Check the rating based on total purchases
    IF TOTAL_PURCHASES > HIGH_LIMIT THEN
 -- Customer Rated High
        DBMS_OUTPUT.PUT_LINE('Customer Rated High');
 -- Display "High Rating"
        DBMS_OUTPUT.PUT_LINE('Display "High Rating"');
    ELSIF TOTAL_PURCHASES > MID_LIMIT THEN
 -- Customer Rated Mid
        DBMS_OUTPUT.PUT_LINE('Customer Rated Mid');
 -- Display "Mid Rating"
        DBMS_OUTPUT.PUT_LINE('Display "Mid Rating"');
    ELSE
 -- Customer Rated Low
        DBMS_OUTPUT.PUT_LINE('Customer Rated Low');
 -- Display "Low Rating"
        DBMS_OUTPUT.PUT_LINE('Display "Low Rating"');
    END IF;
 -- End of Flowchart
    DBMS_OUTPUT.PUT_LINE('End of Flowchart');
END;
/

-- Assignment 2-4: Using CASE Statements
-- Create a block using a CASE statement to perform the actions described in Assignment 2-2. Use a scalar variable for the total purchase amount, and initialize this variable to different values to test your block.
DECLARE
    TOTAL_PURCHASES NUMBER := 150; -- Initialize total purchases to test the block
BEGIN
 -- Enter Total Purchases
    DBMS_OUTPUT.PUT_LINE('Enter Total Purchases: '
                         || TOTAL_PURCHASES);
 -- Evaluate the rating based on total purchases using CASE statement
    CASE
        WHEN TOTAL_PURCHASES > 200 THEN
 -- Customer Rated High
            DBMS_OUTPUT.PUT_LINE('Customer Rated High');
 -- Display "High Rating"
            DBMS_OUTPUT.PUT_LINE('Display "High Rating"');
        WHEN TOTAL_PURCHASES > 100 THEN
 -- Customer Rated Mid
            DBMS_OUTPUT.PUT_LINE('Customer Rated Mid');
 -- Display "Mid Rating"
            DBMS_OUTPUT.PUT_LINE('Display "Mid Rating"');
        ELSE
 -- Customer Rated Low
            DBMS_OUTPUT.PUT_LINE('Customer Rated Low');
 -- Display "Low Rating"
            DBMS_OUTPUT.PUT_LINE('Display "Low Rating"');
    END CASE;
 -- End of Block
    DBMS_OUTPUT.PUT_LINE('End of Block');
END;
/

-- Assignment 2-5: Using a Boolean Variable
-- Brewbean’s needs program code to indicate whether an amount is still due on an account when a payment is received. Create a PL/SQL block using a Boolean variable to indicate whether an amount is still due. Declare and initialize two variables to provide input for the account balance and the payment amount received. A TRUE Boolean value should indicate an amount is still owed, and a FALSE value should indicate the account is paid in full. Use output statements to confirm that the Boolean variable is working correctly.
DECLARE
  vAccountBalance NUMBER := 1000; -- Initialize with the account balance
  vPaymentReceived NUMBER := 500; -- Initialize with the payment amount received
  vAmountDue BOOLEAN; -- Boolean variable to indicate whether an amount is still due
BEGIN
  -- Check if there is still an amount due
  IF vPaymentReceived < vAccountBalance THEN
    vAmountDue := TRUE; -- Set to TRUE if amount is still due
  ELSE
    vAmountDue := FALSE; -- Set to FALSE if account is paid in full
  END IF;

  -- Output statements to confirm the Boolean variable
  IF vAmountDue THEN
    DBMS_OUTPUT.PUT_LINE('Amount is still due on the account.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Account is paid in full.');
  END IF;
END;
/


-- Assignment 2-6: Using Looping Statements
-- Create a block using a loop that determines the number of items that can be purchased based on the item prices and the total available to spend. Include one initialized variable to represent the price and another to represent the total available to spend. (You could solve it with division, but you need to practice using loop structures.) The block should include statements to display the total number of items that can be purchased and the total amount spent.
DECLARE
  vItemPrice NUMBER := 50; -- Initialize with the price of one item
  vTotalAvailable NUMBER := 300; -- Initialize with the total amount available to spend
  vItemsPurchased NUMBER := 0; -- Initialize the count of items purchased

BEGIN
  -- Loop to determine the number of items that can be purchased
  WHILE vTotalAvailable >= vItemPrice LOOP
    vItemsPurchased := vItemsPurchased + 1;
    vTotalAvailable := vTotalAvailable - vItemPrice;
  END LOOP;

  -- Display the results
  DBMS_OUTPUT.PUT_LINE('Total items purchased: ' || vItemsPurchased);
  DBMS_OUTPUT.PUT_LINE('Total amount spent: ' || (vItemsPurchased * vItemPrice));
END;
/


-- Assignment 2-7: Creating a Flowchart
-- Brewbean’s determines shipping costs based on the number of items ordered and club
-- membership status. The applicable rates are shown in the following chart. Develop a flowchart
-- to outline the condition-processing steps needed to handle this calculation.
-- Quantity of Items Nonmember Shipping Cost Member Shipping Cost
-- Up to 3 $5.00 $3.00
-- 4–6 $7.50 $5.00
-- 7–10 $10.00 $7.00
-- More than 10 $12.00 $9.00
-- Brewbean's Shipping Cost Calculation Flowchart
-- Start
-- |
-- v
-- [Declare QUANTITY_OF_ITEMS, NONMEMBER_COST, MEMBER_COST, IS_MEMBER]
-- |
-- v
-- [Initialize QUANTITY_OF_ITEMS to 5, IS_MEMBER to False]
-- |
-- v
-- [Display "Enter Quantity of Items: 5"]
-- |
-- v
-- [Display "Are you a Club Member? (Yes/No)"]
-- |
-- v
-- [Check if QUANTITY_OF_ITEMS <= 3]
-- |
-- v
-- |-----[True]
-- |       |
-- |       v
-- |       [Check if IS_MEMBER is True]
-- |       |
-- |       v
-- |       |-----[True]
-- |       |       |
-- |       |       v
-- |       |       [Display "Member Shipping Cost: $3.00"]
-- |       |       |
-- |       |       v
-- |       |       [Display "End of Flowchart"]
-- |       |
-- |       |-----[False]
-- |       |       |
-- |       |       v
-- |       |       [Display "Nonmember Shipping Cost: $5.00"]
-- |       |       |
-- |       |       v
-- |       |       [Display "End of Flowchart"]
-- |
-- |-----[False]
-- |       |
-- |       v
-- |       [Check if QUANTITY_OF_ITEMS <= 6]
-- |       |
-- |       v
-- |       |-----[True]
-- |       |       |
-- |       |       v
-- |       |       [Check if IS_MEMBER is True]
-- |       |       |
-- |       |       v
-- |       |       |-----[True]
-- |       |       |       |
-- |       |       |       v
-- |       |       |       [Display "Member Shipping Cost: $5.00"]
-- |       |       |       |
-- |       |       |       v
-- |       |       |       [Display "End of Flowchart"]
-- |       |       |
-- |       |       |-----[False]
-- |       |       |       |
-- |       |       |       v
-- |       |       |       [Display "Nonmember Shipping Cost: $7.50"]
-- |       |       |       |
-- |       |       |       v
-- |       |       |       [Display "End of Flowchart"]
-- |       |
-- |       |-----[False]
-- |               |
-- |               v
-- |               [Check if QUANTITY_OF_ITEMS <= 10]
-- |               |
-- |               v
-- |               |-----[True]
-- |               |       |
-- |               |       v
-- |               |       [Check if IS_MEMBER is True]
-- |               |       |
-- |               |       v
-- |               |       |-----[True]
-- |               |       |       |
-- |               |       |       v
-- |               |       |       [Display "Member Shipping Cost: $7.00"]
-- |               |       |       |
-- |               |       |       v
-- |               |       |       [Display "End of Flowchart"]
-- |               |       |
-- |               |       |-----[False]
-- |               |       |       |
-- |               |       |       v
-- |               |       |       [Display "Nonmember Shipping Cost: $10.00"]
-- |               |       |       |
-- |               |       |       v
-- |               |       |       [Display "End of Flowchart"]
-- |               |
-- |               |-----[False]
-- |                       |
-- |                       v
-- |                       [Check if IS_MEMBER is True]
-- |                       |
-- |                       v
-- |                       |-----[True]
-- |                       |       |
-- |                       |       v
-- |                       |       [Display "Member Shipping Cost: $9.00"]
-- |                       |       |
-- |                       |       v
-- |                       |       [Display "End of Flowchart"]
-- |                       |
-- |                       |-----[False]
-- |                               |
-- |                               v
-- |                               [Display "Nonmember Shipping Cost: $12.00"]
-- |                               |
-- |                               v
-- |                               [Display "End of Flowchart"]
-- |
-- v
-- [End]

-- Assignment 2-8: Using IF Statements
-- Create a block to accomplish the task outlined in Assignment 2-7. Include a variable containing
-- a Y or N to indicate membership status and a variable to represent the number of items
-- purchased. Test with a variety of values.


-- Assignment 2-9: Using a FOR Loop
-- Create a PL/SQL block using a FOR loop to generate a payment schedule for a donor’s pledge,
-- which is to be paid monthly in equal increments. Values available for the block are starting
-- payment due date, monthly payment amount, and number of total monthly payments for the
-- pledge. The list that’s generated should display a line for each monthly payment showing
-- payment number, date due, payment amount, and donation balance (remaining amount of
-- pledge owed).


-- Assignment 2-10: Using a Basic Loop
-- Accomplish the task in Assignment 2-9 by using a basic loop structure.


-- Assignment 2-11: Using a WHILE Loop
-- Accomplish the task in Assignment 2-9 by using a WHILE loop structure. Instead of displaying
-- the donation balance (remaining amount of pledge owed) on each line of output, display the
-- total paid to date.


-- Assignment 2-12: Using a CASE Expression
-- Donors can select one of three payment plans for a pledge indicated by the following codes:
-- 0 = one-time (lump sum) payment, 1 = monthly payments over one year, and 2 = monthly
-- payments over two years. A local business has agreed to pay matching amounts on pledge payments during the current month. A PL/SQL block is needed to identify the matching
-- amount for a pledge payment. Create a block using input values of a payment plan code
-- and a payment amount. Use a CASE expression to calculate the matching amount, based on
-- the payment plan codes 0 = 25%, 1 = 50%, 2 = 100%, and other = 0. Display the
-- calculated amount.


-- Assignment 2-13: Using Nested IF Statements
-- An organization has committed to matching pledge amounts based on the donor type and
-- pledge amount. Donor types include I = Individual, B = Business organization, and G = Grant
-- funds. The matching percents are to be applied as follows:
-- Donor Type Pledge Amount Matching %
-- I $100–$249 50%
-- I $250–$499 30%
-- I $500 or more 20%
-- B $100–$499 20%
-- B $500–$999 10%
-- B $1,000 or more 5%
-- G $100 or more 5%
-- Create a PL/SQL block using nested IF statements to accomplish the task. Input values for
-- the block are the donor type code and the pledge amount.
-- Case Projects
-- Case 2-1: Flowcharting
-- Find a Web site with basic information on flowcharting. Describe at least two interesting aspects
-- of flowcharting discussed on the Web site.
-- Case 2-2: Working with More Movie Rentals
-- The More Movie Rentals Company wants to display a rating value for a movie based on the
-- number of times the movie has been rented. The rating assignments are outlined in the
-- following chart:
-- Number of Rentals Rental Rating
-- Up to 5 Dump
-- 5–20 Low
-- 21–35 Mid
-- More than 35 High
-- Create a flowchart and then a PL/SQL block to address the processing needed. The block
-- should determine and then display the correct rental rating. Test the block, using a variety of
-- rental amounts.
