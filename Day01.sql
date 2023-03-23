--1) ���缭���� ���� �䱸�ϴ� ���� ������ ���� SQL ���� �ۼ��Ͻÿ�.

--1.1 ������ȣ�� 1�� ������ �̸�
SELECT bookname 
FROM book 
where bookid=1;

--1.2 ������ 20000�� �̻��� ������ �̸�
SELECT bookname 
FROM book 
where price>=20000;

--1.3 �������� �� ���ž�
SELECT SUM(saleprice) AS �ѱ��ž� 
FROM orders 
WHERE custid = 1;

--1.4 �������� ������ ������ ��
SELECT COUNT(*) 
FROM orders 
WHERE custid = 1;

--1.5 �������� ������ ������ ���ǻ� ��
SELECT count(distinct publisher)
FROM ORDERS, book
where orders.bookid = book.bookid and 
    orders.custid = (SELECT custid from customer where name LIKE '������');

--1.6 �������� ������ ������ �̸�, ����, ������ �ǸŰ����� ����
SELECT distinct bookname, saleprice, (price-saleprice)
from customer, book, orders
WHERE orders.bookid = book.bookid and
    orders.custid = (SELECT custid from customer where name like '������');

--1.7 �������� �������� ���� ������ �̸�
SELECT distinct bookname
from book
MINUS
SELECT bookname
from book, customer, orders
where orders.bookid = book.bookid and
    orders.custid = (SELECT custid from customer where name like '������');
--2)���缭���� ��ڿ� �濵�ڰ� �䱸�ϴ� ���� ������ ���� SQL ���� �ۼ��Ͻÿ�.

--2.1 ���缭�� ������ �� ����
SELECT COUNT(bookid) AS ������_��_���� 
FROM book;

--2.2 ���缭���� ������ ����ϴ� ���ǻ��� �� ����
SELECT  Count(distinct publisher) AS ���ǻ���_��_���� 
FROM book;

--2.3 ��� ���� �̸�, �ּ�
SELECT name, address 
FROM customer;

--2.4 2014�� 7�� 4��~2014�� 7�� 7�� ���̿� �ֹ����� ������ �ֹ���ȣ
SELECT orderid 
FROM orders 
WHERE ORDERDATE BETWEEN '14/07/04' AND '14/07/07';

--2.5 2014�� 7�� 4��~2014�� 7�� 7�� ���̿� �ֹ����� ������ ������ ������ �ֹ���ȣ
SELECT orderid 
FROM orders 
WHERE ORDERDATE < '14/07/04' OR ORDERDATE > '14/07/07';

--2.6 ���� '��'���� ���� �̸��� �ּ�
Select name,address 
from customer 
where name like '��%';

--2.7 ���� '��'���̰� �̸��� '��'�� ������ ���� �̸��� �ּ�
SELECT name,address 
FROM customer 
where name like '��_��';

--����
-- ������ 20000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
SELECT customer.name, book.bookname
FROM customer, orders, book
WHERE orders.custid = customer.custid 
    AND book.bookid = orders.bookid
    AND book.price = 20000;
    
--2.8 �ֹ����� ���� ���� �̸�(�μ����� ���)
SELECT name
FROM  Customer
WHERE custid NOT IN(SELECT custid FROM Orders);

--2.9 �ֹ� �ݾ��� �Ѿװ� �ֹ��� ��� �ݾ�
SELECT SUM(saleprice), AVG(saleprice)
from orders;

--2.10 ���� �̸��� ���� ���ž�
SELECT NAME, sum(saleprice)
FROM customer, orders
where orders.custid = customer.custid
GROUP BY customer.name;

--2.11 ���� �̸��� ���� ������ ���� ���
SELECT NAME, bookname
FROM customer, orders, book
where orders.custid = customer.custid AND orders.bookid = book.bookid;

--2.12 ������ ����(Book ���̺�)�� �ǸŰ���(Orders ���̺�)�� ���̰� ���� ���� �ֹ�
SELECT *
FROM orders, book
WHERE book.bookid = orders.bookid and
    (price-saleprice) = 
    (SELECT MAX(price-saleprice) 
    FROM book, orders
    WHERE book.bookid = orders.bookid);

--2.13 ������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸�
select customer.name ,AVG(saleprice)
from orders, customer
WHERE orders.custid = customer.custid
group by name
HAVING AVG(saleprice) > (SELECT AVG(saleprice) from orders);
