--1 고객별 구매한 책의 총액, 고객번호, 주소
select custid, (select address
                from customer cs
                where cs.custid = od.custid) "address",
                sum(saleprice) "total"
from orders od
group by od.custid;

--2 고객별 구매한 책의 평균액, 고객이름
select cs.name, s
from (select custid, avg(saleprice) s
        from orders
        group by custid) od, customer cs
where cs.custid = od.custid;

--3 고객번호가 4보다 작은 고객들의 총 구매액
select sum(saleprice) "total"
from orders od
where exists (select *
                from customer cs
                where custid <= 3 and cs.custid = od.custid);
                
-- Book 테이블에 새로운 도서 '스포츠 의학'을 삽입하시오. 스포츠 의학은 한솔의학서적에서 출간했으며 가격은 90000원이다.
SELECT *
FROM BOOK;

INSERT INTO BOOK(BOOKID, BOOKNAME, PUBLISHER, PRICE)
        VALUES (11, '스포츠 의학', '한솔의학서적', 90000);
--같은 역할
INSERT INTO BOOK
        VALUES (11, '스포츠 의학', '한솔의학서적', 90000);

--null값을 넣으려면 key값을 넣어줘야 한다.
INSERT INTO BOOK(BOOKID, BOOKNAME, PUBLISHER)
        VALUES (14, '스포츠 의학', '한솔의학서적');

---        
CREATE TABLE Imported_Book (
  bookid      NUMBER ,
  bookname    VARCHAR(40),
  publisher   VARCHAR(40),
  price       NUMBER(8) 
);
INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);

COMMIT;

-- Bulk insertions
INSERT   INTO Book(bookid, bookname, price, publisher)
	SELECT bookid, bookname, price, publisher
FROM  Imported_book;

--3 마당서점에서 다음의 심화된 질문에 대해 SQL 문을 작성하시오.

--(1) 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
SELECT NAME
FROM customer
where custid in (select custid 
                    from orders 
                    where bookid in (select bookid 
                                    from book 
                                    where publisher in (select publisher 
                                                        from book 
                                                        where bookid in (SELECT bookid 
                                                                        FROM orders 
                                                                        WHERE custid = 1)))) AND custid <> 1;

--(2) 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름
SELECT customer.name 
FROM orders, book, customer
WHERE orders.custid = customer.custid 
    AND book.bookid = orders.bookid
GROUP BY customer.name
HAVING COUNT(DISTINCT publisher) >= 2;

--(3) (생략) 전체 고객의 30% 이상이 구매한 도서
SELECT book.bookname
FROM orders, book, customer
WHERE orders.custid = customer.custid
        AND book.bookid = orders.bookid
GROUP BY book.bookname
HAVING COUNT(customer.custid) / (SELECT COUNT(distinct custid) 
                                FROM customer) > 0.3 ;


--4 다음 질의에 대해 DML 문을 작성하시오.

--(1) 새로운 도서 (‘스포츠 세계’, ‘대한미디어’, 10000원)이 마당서점에 입고되었다. 
--    삽입이 안 될 경우 필요한 데이터가 더 있는지 찾아보자.
INSERT INTO BOOK(BOOKID, BOOKNAME, PUBLISHER, PRICE)
        VALUES (12, '스포츠 세계', '대한미디어', 10000);
--(2) ‘삼성당’에서 출판한 도서를 삭제해야 한다.
DELETE FROM book
WHERE publisher = '삼성당';
--(3) ‘이상미디어’에서 출판한 도서를 삭제해야 한다. 삭제가 안 될 경우 원인을 생각해보자.
DELETE FROM book
WHERE publisher = '이상미디어';

--(4) 출판사 ‘대한미디어’가 ‘대한출판사’로 이름을 바꾸었다.
UPDATE book
SET publisher = '대한출판사'
WHERE publisher = '대한미디어';