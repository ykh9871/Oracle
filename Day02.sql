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