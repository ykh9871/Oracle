--[Oracle] �ý��ۿ� ���� & DML ����

--�ý��ۿ� ���� ��ɾ�

CREATE USER : --������ ���̽� ���� ���� ����

SELECT ANY TABLE : --��� ������ ���̺� ��ȸ ����

CREATE SESSION : --�����ͺ��̽� ���� ����

CREATE TABLE : --���̺� ���� ����

CREATE VIEW : view --���� ����

CREATE PROCEDURE USER : procedure, function, package --���� ����

CREATE SEQUENCE  : sequence --���� ����

SYSDBA : --�����ͺ��̽� ���� �ְ� ����

SYSOPER : --�����ͺ��̽� ���� ����
DML --�����ֱ�

GRANT  DELETE, INSERT, SELECT, UPDATE ON ���̺�� TO ����ID;

REVOKE DELETE, INSERT, SELECT, UPDATE ON ���̺�� TO ����ID;

--DBA �����ֱ�
GRANT CONNECT, RESOURCE, DBA TO ����ID;