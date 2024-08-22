create schema if not exists company;
use company;

create table company.employee(
	Fname varchar (20) NOT NULL, 
	Miniti char,
	Lname varchar (20) NOT NULL, 
	SSN char (9) NOT NULL,
	Bdate DATE,
	Address varchar(40),
	sex char, 
	salary decimal (10, 2),
	Super_SSN char(9),
	Dno int not null,
	primary key (Ssn)
);

alter table company.employee
	add constraint chk_salary_employee check (Salary >2000.0);

create table departament(
	Dname varchar(15) not null,
	Dnumber int not null,
	Mgr_ssn char (9),
	Mgr_start_date date,
	Dept_create_date date,
	constraint chk_date_dept check (Dept_create_date < Mgr_start_date), 
	constraint pk_dept primary key (Dnumber),
	constraint unique_naem_dpt unique(Dname),
	foreign key (mgr_ssn) references employee(Ssn)
);

desc departament;
    
create table dept_location(
	Dnumber int not null,
	Dlocation varchar (20) not null, 
	constraint pk_dept_locations primary key (Dnumber, Dlocation),
	constraint fk_dept_locations foreign key (Dnumber) references departament(Dnumber)
);
desc dept_location;

create table project (
	Pname varchar (20) not null,
	Pnumber int not null,
	Plocation varchar(20),
	Dnum int not null,
	primary key (Pnumber),
	constraint unique_project unique (Pname),
	constraint fk_project foreign key (Dnum) references departament(Dnumber)
);
desc project;

create table works_on(
	Essn char (9) not null,
	Pno int not null,	
	Hours decimal(3, 1) not null,
	primary key (Essn, Pno), 
	constraint fk_works_on foreign key (Essn) references employee(Ssn),
	constraint fk_works_on_Pnumber foreign key (Pno) references project(Pnumber)
);
desc works_on;

create table dependent(
	Essn char (9) not null,
	Dependent_name varchar (15) not null,
	Sex char,
	Bdate date,
	Relationship varchar (8),
	primary key (Essn, Dependent_name),
	constraint fk_dependent foreign key (Essn) references employee(Ssn)
);
desc dependent;

alter table employee
	add constraint fk_employee
    foreign key(Super_ssn) references Employee (ssn)
    on delete set null
    on update cascade;
    
show tables;
select * from information_schema.table_constraints
	where constraint_schema = 'company'; 
    
