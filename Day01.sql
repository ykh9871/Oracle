--1) 마당서점의 고객이 요구하는 다음 질문에 대해 SQL 문을 작성하시오.

--1.1 도서번호가 1인 도서의 이름
SELECT bookname 
FROM book 
where bookid=1;

--1.2 가격이 20000원 이상인 도서의 이름
SELECT bookname 
FROM book 
where price>=20000;

--1.3 박지성의 총 구매액
SELECT SUM(saleprice) AS 총구매액 
FROM orders 
WHERE custid = 1;

--1.4 박지성이 구매한 도서의 수
SELECT COUNT(*) 
FROM orders 
WHERE custid = 1;

--1.5 박지성이 구매한 도서의 출판사 수
SELECT count(distinct publisher)
FROM ORDERS, book
where orders.bookid = book.bookid and 
    orders.custid = (SELECT custid from customer where name LIKE '박지성');

--1.6 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
SELECT distinct bookname, saleprice, (price-saleprice)
from customer, book, orders
WHERE orders.bookid = book.bookid and
    orders.custid = (SELECT custid from customer where name like '박지성');

--1.7 박지성이 구매하지 않은 도서의 이름
SELECT distinct bookname
from book
MINUS
SELECT bookname
from book, customer, orders
where orders.bookid = book.bookid and
    orders.custid = (SELECT custid from customer where name like '박지성');
--2)마당서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL 문을 작성하시오.

--2.1 마당서점 도서의 총 개수
SELECT COUNT(bookid) AS 도서의_총_개수 
FROM book;

--2.2 마당서점에 도서를 출고하는 출판사의 총 개수
SELECT  Count(distinct publisher) AS 출판사의_총_개수 
FROM book;

--2.3 모든 고객의 이름, 주소
SELECT name, address 
FROM customer;

--2.4 2014년 7월 4일~2014년 7월 7일 사이에 주문받은 도서의 주문번호
SELECT orderid 
FROM orders 
WHERE ORDERDATE BETWEEN '14/07/04' AND '14/07/07';

--2.5 2014년 7월 4일~2014년 7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호
SELECT orderid 
FROM orders 
WHERE ORDERDATE < '14/07/04' OR ORDERDATE > '14/07/07';

--2.6 성이 '김'씨인 고객의 이름과 주소
Select name,address 
from customer 
where name like '김%';

--2.7 성이 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소
SELECT name,address 
FROM customer 
where name like '김_아';

--조인
-- 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT customer.name, book.bookname
FROM customer, orders, book
WHERE orders.custid = customer.custid 
    AND book.bookid = orders.bookid
    AND book.price = 20000;
    
--2.8 주문하지 않은 고객의 이름(부속질의 사용)
SELECT name
FROM  Customer
WHERE custid NOT IN(SELECT custid FROM Orders);

--2.9 주문 금액의 총액과 주문의 평균 금액
SELECT SUM(saleprice), AVG(saleprice)
from orders;

--2.10 고객의 이름과 고객별 구매액
SELECT NAME, sum(saleprice)
FROM customer, orders
where orders.custid = customer.custid
GROUP BY customer.name;

--2.11 고객의 이름과 고객이 구매한 도서 목록
SELECT NAME, bookname
FROM customer, orders, book
where orders.custid = customer.custid AND orders.bookid = book.bookid;

--2.12 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
SELECT *
FROM orders, book
WHERE book.bookid = orders.bookid and
    (price-saleprice) = 
    (SELECT MAX(price-saleprice) 
    FROM book, orders
    WHERE book.bookid = orders.bookid);

--2.13 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
select customer.name ,AVG(saleprice)
from orders, customer
WHERE orders.custid = customer.custid
group by name
HAVING AVG(saleprice) > (SELECT AVG(saleprice) from orders);
