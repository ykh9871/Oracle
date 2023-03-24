--삽입 작업을 하는 프로시저
--예제 5-1 Book테이블에 한 개의 투플을 삽입하는 프로시저 (InsertBook)
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

--/* 프로시저 InsertBook을 테스트하는 부분 */
EXEC InsertBook(13, '스포츠과학', '마당과학서적', 25000);
SELECT * FROM Book;
--------------------------------------------------------------------------
--제어문을 사용하는 프로시저
--예제 5-2 동일한 도서가 있는지 점검한 후 있으면 가격만 수정하고 없으면 새로 삽입하는 프로시저(BookInsertOrUpdate)
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

/* BookInsertOrPriceUpdate 프로시저를 실행하여 테스트하는 부분 */
EXEC BookInsertOrPriceUpdate(15, '스포츠 즐거움', '마당과학서적', 25000);
SELECT * FROM Book; /* 15번 투플 삽입 결과 확인 */
/* BookInsertOrPriceUpdate 프로시저를 실행하여 테스트하는 부분 */
EXEC BookInsertOrPriceUpdate(15, '스포츠 즐거움', '마당과학서적', 20000);
SELECT * FROM Book; /* 15번 투플 가격 변경 확인 */

-------------------------------------------------------------------
--결과를 반환하는 프로시저
--예제 5-3 Book 테이블에 저장된 도서의 평균가격을 반환하는 프로시저(AveragePrice)
CREATE OR REPLACE PROCEDURE AveragePrice(
    AverageVal OUT NUMBER)
AS
BEGIN
    SELECT AVG(price) INTO AverageVal FROM Book WHERE price IS NOT NULL;
END;

/* 프로시저 AveragePrice를 테스트하는 부분 */
SET SERVEROUTPUT ON ;
DECLARE
    AverageVal NUMBER;
BEGIN
    AveragePrice(AverageVal);
    DBMS_OUTPUT.PUT_LINE('책값 평균: '|| AverageVal);
END;
--------------------------------------------------------------------------------
--커서를 사용하는 프로시저
--예제 5-4 Orders 테이블의 판매 도서에 대한 이익을 계산하는 프로시저(Interest)
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
    DBMS_OUTPUT.PUT_LINE(' 전체 이익 금액 = ' || myInterest);
END;

/* Interest 프로시저를 실행하여 판매된 도서에 대한 이익금을 계산 */
SET SERVEROUTPUT ON;
EXEC Interest;