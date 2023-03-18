 CREATE USER assignmentABMS
 IDENTIFIED BY password  ;


 GRANT CONNECT TO assignmentABMS;
 GRANT RESOURCE TO assignmentABMS;
 GRANT CREATE SESSION TO assignmentABMS;
 GRANT CREATE TABLE TO assignmentABMS;
 GRANT CREATE VIEW TO assignmentABMS;


CREATE TABLE Department
(
Deptid VARCHAR2(20),
name VARCHAR2(50)   ,
CONSTRAINT PK_Dep PRIMARY KEY (Deptid)
);



CREATE TABLE  SalaryGrade
(
SalaryCode VARCHAR(20),
StartSalary NUMBER(10),
FinishSalary NUMBER(10)    ,
CONSTRAINT PK_Sal PRIMARY KEY (SalaryCode)

);



CREATE TABLE pensionschema
(
SchemeID VARCHAR(20),
Name VARCHAR(20),
rate DECIMAL(5,3),
CONSTRAINT PK_sch PRIMARY KEY (SchemeID)
);

CREATE   TABLE   Employee
(
EmpID VARCHAR2(20),
Name VARCHAR(30),
Address	VARCHAR(30),
DOB	 DATE     ,
Job	 VARCHAR(20) ,
SalaryCode 	VARCHAR(20)  ,
DeptID	  VARCHAR(20) ,
Manager	  VARCHAR(20),
SchemeID   VARCHAR(20),
CONSTRAINT PK_em PRIMARY KEY (EmpID)
);


ALTER  TABLE Employee ADD CONSTRAINT FK_Sal
FOREIGN KEY(SalaryCode) REFERENCES SalaryGrade(SalaryCode);


 ALTER  TABLE Employee ADD CONSTRAINT FK_dep
FOREIGN KEY(DeptID) REFERENCES Department(DeptID);

 ALTER  TABLE Employee ADD CONSTRAINT FK_Schema
FOREIGN KEY(SchemeID) REFERENCES pensionschema(SchemeID);


insert into department (deptid, name) values('D10', 'Administration');
insert into department (deptid, name) values('D20', 'Finance');
insert into department (deptid, name) values('D30', 'Sales');
insert into department (deptid, name) values('D40', 'Maintenance');
insert into department (deptid, name) values('D50', 'IT Support');


insert into salarygrade (salarycode, startsalary, finishsalary) values('S1', '15000', '18000');
 insert into salarygrade (salarycode, startsalary, finishsalary) values('S2', '18001', '22000');
insert into salarygrade (salarycode, startsalary, finishsalary) values('S3', '22001', '25000');
insert into salarygrade (salarycode, startsalary, finishsalary) values('S4', '25001', '29000');
insert into salarygrade (salarycode, startsalary, finishsalary) values('S5', '29001', '38000');





insert into pensionschema (schemeId, name, rate) values('S110', 'AXA', '0.5');
insert into pensionschema (schemeId, name, rate) values('S121', 'Premier', '0.6');
insert into pensionschema (schemeId, name, rate) values('S124', 'Stakeholder', '0.4');
insert into pensionschema (schemeId, name, rate) values('S116', 'Standard', '0.4');


select * from pensionschema;



insert into employee (empid, name, address, dob, job, salarycode, deptid, manager, schemeid)
values('E101', 'Young, S.', '199 London Road', TO_DATE('1976-03-05','YYYY-MM-DD'), 'Clerk', 'S1','D10', 'E110', 'S116');
insert into employee (empid, name, address, dob, job, salarycode, deptid, manager, schemeid)
values('E301', 'April, H.', '20 Glade close', TO_DATE('1979-03-10','YYYY-MM-DD'), 'Sales Person', 'S2','D30', 'E310', 'S124');
insert into employee (empid, name, address, dob, job, salarycode, deptid, manager, schemeid)
values('E310', 'Newgate,E.', '10 Heap Street', TO_DATE('1980-11-28','YYYY-MM-DD'), 'Manager', 'S5','D30', '', 'S121');
insert into employee (empid, name, address, dob, job, salarycode, deptid, manager, schemeid)
values('E501', 'Teach, E.', '22 railway road', TO_DATE('1972-02-12','YYYY-MM-DD'), 'Analyst', 'S5','D50', '', 'S121');
insert into employee (empid, name, address, dob, job, salarycode, deptid, manager, schemeid)
 values('E102', 'Hawkins, M.', '3 High Street', TO_DATE('1974-07-13','YYYY-MM-DD'), 'Clerk', 'S1','D10', 'E110', 'S116');
insert into employee (empid, name, address, dob, job, salarycode, deptid, manager, schemeid)
 values('E110', 'Watkins,J.', '11 crescent road', TO_DATE('1969-06-25','YYYY-MM-DD'), 'Manager', 'S5','D10', '', 'S121');


select * from employee;

 _------------------Question A
select e.name, s.startsalary, d.deptid from
employee e
join salarygrade s on s.salarycode = e.salarycode
join department d on d.deptid = e.deptid
order by e.name asc, d.deptid desc;



 ---------------question B------------------

select distinct p.name,(select COUNT(*)
from employee e where p.schemeid = e.schemeid) as employee_count
from employee e join pensionschema p on p.schemeid = e.schemeid;



------------------Question C----------------
select COUNT(*) as employee_no  from employee e
join salarygrade s on e.salarycode = s.salarycode
where e.manager is null and s.finishsalary > 35000;

----------------QuestionD----

select e.empid, e.name,

 (select e2.name from employee e2 where e.manager = e2.empid) as managername from
employee e;