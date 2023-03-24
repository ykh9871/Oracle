--VIEW
--기본 문법(Book 테이블에서 ‘축구’라는 문구가 포함된 자료만 보여주는 뷰)
CREATE VIEW vw_Book
AS SELECT *
FROM Book
WHERE bookname LIKE '%축구%';

--질의 4-20   주소에 ‘대한민국’을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 단, 뷰의 이름은 vw_Customer로 한다.
CREATE VIEW vw_Customer
AS SELECT      *
     FROM 	    Customer
     WHERE    address LIKE '%대한민국%';
--결과 확인
SELECT 	*
FROM 	vw_Customer;

--질의 4-21   Orders 테이블에 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, ‘김연아’ 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.
CREATE VIEW vw_Orders (orderid, custid, name, bookid, bookname, saleprice, orderdate)
AS SELECT 	    od.orderid, od.custid, cs.name, od.bookid, bk.bookname, od.saleprice, od.orderdate
FROM 	    Orders od, Customer cs, Book bk
WHERE    od.custid =cs.custid AND od.bookid =bk.bookid;

--결과 확인
SELECT 	orderid, bookname, saleprice
FROM 	vw_Orders
WHERE 	name='김연아';

--질의 4-22   [질의 4-20]에서 생성한 뷰 vw_Customer는 주소가 대한민국인 고객을 보여준다. 이 뷰를 영국을 주소로 가진 고객으로 변경하시오. phone 속성은 필요 없으므로 포함시키지 마시오.
CREATE OR REPLACE VIEW vw_Customer (custid, name, address)
AS SELECT custid, name, address
FROM Customer
WHERE address LIKE '%영국%';

--결과 확인
SELECT *
FROM vw_Customer;