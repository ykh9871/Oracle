--���� 5-6 �Ǹŵ� ������ ���� ������ ����ϴ� �Լ�(fnc_Interest)
CREATE OR REPLACE FUNCTION fnc_Interest(
    price NUMBER) RETURN INT
IS
    myInterest NUMBER;
BEGIN
/* ������ 30,000�� �̻��̸� 10%, 30,000�� �̸��̸� 5% */
    IF Price >= 30000 THEN myInterest := Price * 0.1;
    ELSE myInterest := Price * 0.05;
   END IF;
   RETURN myInterest;
END;
--
--------------------------------------------------------------------------------------------
/* Orders ���̺��� �� �ֹ��� ���� ������ ��� */
SELECT custid, orderid, saleprice, fnc_Interest(saleprice) interest
FROM Orders;