--���� �۾��� �ϴ� ���ν���
--���� 5-1 Book���̺� �� ���� ������ �����ϴ� ���ν��� (InsertBook)
CREATE OR REPLACE PROCEDURE InsertBook(
    myBookID IN NUMBER,
    myBookName IN VARCHAR2,
    myPublisher IN VARCHAR2,
    myPrice IN NUMBER)
AS
BEGIN
    INSERT INTO Book(bookid, bookname, publisher, price)
    VALUES(myBookID, myBookName, myPublisher, myPrice);
END;

--/* ���ν��� InsertBook�� �׽�Ʈ�ϴ� �κ� */
EXEC InsertBook(13, '����������', '������м���', 25000);
SELECT * FROM Book;
--------------------------------------------------------------------------
--����� ����ϴ� ���ν���
--���� 5-2 ������ ������ �ִ��� ������ �� ������ ���ݸ� �����ϰ� ������ ���� �����ϴ� ���ν���(BookInsertOrUpdate)
CREATE OR REPLACE PROCEDURE BookInsertOrpPriceUpdate(
    myBookID NUMBER,
    myBookName VARCHAR2,
    myPublisher VARCHAR2,
    myPrice INT)
 AS
    mycount NUMBER;
 BEGIN
   SELECT COUNT(*) INTO mycount FROM Book
     WHERE bookname LIKE myBookName;
   IF mycount!=0 THEN
     UPDATE Book SET price = myPrice
       WHERE bookname LIKE myBookName;
   ELSE
     INSERT INTO Book(bookid, bookname, publisher, price)
       VALUES(myBookID, myBookName, myPublisher, myPrice);
   END IF;
END;

/* BookInsertOrPriceUpdate ���ν����� �����Ͽ� �׽�Ʈ�ϴ� �κ� */
EXEC BookInsertOrPriceUpdate(15, '������ ��ſ�', '������м���', 25000);
SELECT * FROM Book; /* 15�� ���� ���� ��� Ȯ�� */
/* BookInsertOrPriceUpdate ���ν����� �����Ͽ� �׽�Ʈ�ϴ� �κ� */
EXEC BookInsertOrPriceUpdate(15, '������ ��ſ�', '������м���', 20000);
SELECT * FROM Book; /* 15�� ���� ���� ���� Ȯ�� */

-------------------------------------------------------------------
--����� ��ȯ�ϴ� ���ν���
--���� 5-3 Book ���̺� ����� ������ ��հ����� ��ȯ�ϴ� ���ν���(AveragePrice)
CREATE OR REPLACE PROCEDURE AveragePrice(
    AverageVal OUT NUMBER)
AS
BEGIN
    SELECT AVG(price) INTO AverageVal FROM Book WHERE price IS NOT NULL;
END;

/* ���ν��� AveragePrice�� �׽�Ʈ�ϴ� �κ� */
SET SERVEROUTPUT ON ;
DECLARE
    AverageVal NUMBER;
BEGIN
    AveragePrice(AverageVal);
    DBMS_OUTPUT.PUT_LINE('å�� ���: '|| AverageVal);
END;
--------------------------------------------------------------------------------
--Ŀ���� ����ϴ� ���ν���
--���� 5-4 Orders ���̺��� �Ǹ� ������ ���� ������ ����ϴ� ���ν���(Interest)
CREATE OR REPLACE PROCEDURE Interest
AS
   myInterest NUMERIC;
   Price NUMERIC;
   CURSOR InterestCursor IS SELECT saleprice FROM Orders;
BEGIN
  myInterest := 0.0;
  OPEN InterestCursor;
  LOOP
      FETCH InterestCursor INTO Price;
      EXIT WHEN InterestCursor%NOTFOUND;
      IF Price >= 30000 THEN
          myInterest := myInterest + Price * 0.1;
      ELSE
          myInterest := myInterest + Price * 0.05;
     END IF;
    END LOOP;
    CLOSE InterestCursor;
    DBMS_OUTPUT.PUT_LINE(' ��ü ���� �ݾ� = ' || myInterest);
END;

/* Interest ���ν����� �����Ͽ� �Ǹŵ� ������ ���� ���ͱ��� ��� */
SET SERVEROUTPUT ON;
EXEC Interest;