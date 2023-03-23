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