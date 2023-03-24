--[Oracle] 시스템에 관한 & DML 권한

--시스템에 관한 명령어

CREATE USER : --데이터 베이스 유저 생성 권한

SELECT ANY TABLE : --모든 유저의 테이블 조회 권한

CREATE SESSION : --데이터베이스 접속 권한

CREATE TABLE : --테이블 생성 권한

CREATE VIEW : view --생성 권한

CREATE PROCEDURE USER : procedure, function, package --생성 권한

CREATE SEQUENCE  : sequence --생성 권한

SYSDBA : --데이터베이스 관리 최고 권한

SYSOPER : --데이터베이스 관리 권한
DML --권한주기

GRANT  DELETE, INSERT, SELECT, UPDATE ON 테이블명 TO 유저ID;

REVOKE DELETE, INSERT, SELECT, UPDATE ON 테이블명 TO 유저ID;

--DBA 권한주기
GRANT CONNECT, RESOURCE, DBA TO 유저ID;