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