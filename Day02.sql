--1 ���� ������ å�� �Ѿ�, ����ȣ, �ּ�
select custid, (select address
                from customer cs
                where cs.custid = od.custid) "address",
                sum(saleprice) "total"
from orders od
group by od.custid;

--2 ���� ������ å�� ��վ�, ���̸�
select cs.name, s
from (select custid, avg(saleprice) s
        from orders
        group by custid) od, customer cs
where cs.custid = od.custid;

--3 ����ȣ�� 4���� ���� ������ �� ���ž�
select sum(saleprice) "total"
from orders od
where exists (select *
                from customer cs
                where custid <= 3 and cs.custid = od.custid);
                
-- Book ���̺� ���ο� ���� '������ ����'�� �����Ͻÿ�. ������ ������ �Ѽ����м������� �Ⱓ������ ������ 90000���̴�.
SELECT *
FROM BOOK;

INSERT INTO BOOK(BOOKID, BOOKNAME, PUBLISHER, PRICE)
        VALUES (11, '������ ����', '�Ѽ����м���', 90000);
--���� ����
INSERT INTO BOOK
        VALUES (11, '������ ����', '�Ѽ����м���', 90000);

--null���� �������� key���� �־���� �Ѵ�.
INSERT INTO BOOK(BOOKID, BOOKNAME, PUBLISHER)
        VALUES (14, '������ ����', '�Ѽ����м���');

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

--3 ���缭������ ������ ��ȭ�� ������ ���� SQL ���� �ۼ��Ͻÿ�.

--(1) �������� ������ ������ ���ǻ�� ���� ���ǻ翡�� ������ ������ ���� �̸�
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

--(2) �� �� �̻��� ���� �ٸ� ���ǻ翡�� ������ ������ ���� �̸�
SELECT customer.name 
FROM orders, book, customer
WHERE orders.custid = customer.custid 
    AND book.bookid = orders.bookid
GROUP BY customer.name
HAVING COUNT(DISTINCT publisher) >= 2;

--(3) (����) ��ü ���� 30% �̻��� ������ ����
SELECT book.bookname
FROM orders, book, customer
WHERE orders.custid = customer.custid
        AND book.bookid = orders.bookid
GROUP BY book.bookname
HAVING COUNT(customer.custid) / (SELECT COUNT(distinct custid) 
                                FROM customer) > 0.3 ;


--4 ���� ���ǿ� ���� DML ���� �ۼ��Ͻÿ�.

--(1) ���ο� ���� (�������� ���衯, �����ѹ̵�, 10000��)�� ���缭���� �԰�Ǿ���. 
--    ������ �� �� ��� �ʿ��� �����Ͱ� �� �ִ��� ã�ƺ���.
INSERT INTO BOOK(BOOKID, BOOKNAME, PUBLISHER, PRICE)
        VALUES (12, '������ ����', '���ѹ̵��', 10000);
--(2) ���Ｚ�硯���� ������ ������ �����ؾ� �Ѵ�.
DELETE FROM book
WHERE publisher = '�Ｚ��';
--(3) ���̻�̵����� ������ ������ �����ؾ� �Ѵ�. ������ �� �� ��� ������ �����غ���.
DELETE FROM book
WHERE publisher = '�̻�̵��';

--(4) ���ǻ� �����ѹ̵��� ���������ǻ硯�� �̸��� �ٲپ���.
UPDATE book
SET publisher = '�������ǻ�'
WHERE publisher = '���ѹ̵��';