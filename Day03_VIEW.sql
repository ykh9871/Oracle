--VIEW
--�⺻ ����(Book ���̺��� ���౸����� ������ ���Ե� �ڷḸ �����ִ� ��)
CREATE VIEW vw_Book
AS SELECT *
FROM Book
WHERE bookname LIKE '%�౸%';

--���� 4-20   �ּҿ� �����ѹα����� �����ϴ� ����� ������ �並 ����� ��ȸ�Ͻÿ�. ��, ���� �̸��� vw_Customer�� �Ѵ�.
CREATE VIEW vw_Customer
AS SELECT      *
     FROM 	    Customer
     WHERE    address LIKE '%���ѹα�%';
--��� Ȯ��
SELECT 	*
FROM 	vw_Customer;

--���� 4-21   Orders ���̺� ���̸��� �����̸��� �ٷ� Ȯ���� �� �ִ� �並 ������ ��, ���迬�ơ� ���� ������ ������ �ֹ���ȣ, �����̸�, �ֹ����� ���̽ÿ�.
CREATE VIEW vw_Orders (orderid, custid, name, bookid, bookname, saleprice, orderdate)
AS SELECT 	    od.orderid, od.custid, cs.name, od.bookid, bk.bookname, od.saleprice, od.orderdate
FROM 	    Orders od, Customer cs, Book bk
WHERE    od.custid =cs.custid AND od.bookid =bk.bookid;

--��� Ȯ��
SELECT 	orderid, bookname, saleprice
FROM 	vw_Orders
WHERE 	name='�迬��';

--���� 4-22   [���� 4-20]���� ������ �� vw_Customer�� �ּҰ� ���ѹα��� ���� �����ش�. �� �並 ������ �ּҷ� ���� ������ �����Ͻÿ�. phone �Ӽ��� �ʿ� �����Ƿ� ���Խ�Ű�� ���ÿ�.
CREATE OR REPLACE VIEW vw_Customer (custid, name, address)
AS SELECT custid, name, address
FROM Customer
WHERE address LIKE '%����%';

--��� Ȯ��
SELECT *
FROM vw_Customer;