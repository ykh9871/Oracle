--예제 5-6 판매된 도서에 대한 이익을 계산하는 함수(fnc_Interest)
CREATE OR REPLACE FUNCTION fnc_Interest(
    price NUMBER) RETURN INT
IS
    myInterest NUMBER;
BEGIN
/* 가격이 30,000원 이상이면 10%, 30,000원 미만이면 5% */
    IF Price >= 30000 THEN myInterest := Price * 0.1;
    ELSE myInterest := Price * 0.05;
   END IF;
   RETURN myInterest;
END;
--
--------------------------------------------------------------------------------------------
/* Orders 테이블에서 각 주문에 대한 이익을 출력 */
SELECT custid, orderid, saleprice, fnc_Interest(saleprice) interest
FROM Orders;