-- Views
use company;

-- Número de Empregados por Dpto e localidade
create view num_emp_por_depto_localidade as 
select 
    e.Dno as Departamento, 
    dl.Dlocation as Localidade, 
    count(*) as Num_Empregados
from 
    employee e
join
    dept_location dl ON e.Dno = dl.Dnumber
group by
    e.Dno, dl.Dlocation;
    
select * from num_emp_por_depto_localidade;

-- Lista de departamentos e seus gerentes  
create view lista_dept_gerentes as 
select 
    d.Dname as Departamento, 
    concat(e.Fname, ' ', e.Lname) as Gerente, 
    d.Mgr_start_date as Inicio_Gerencia
from 
    departament d
join 
    employee e on d.Mgr_ssn = e.Ssn;
    
select * from lista_dept_gerentes;

-- Projetos com maior número de empregados
create view projetos_mais_empregados as 
select 
    p.Pname as Projeto, 
    p.Plocation as Localidade, 
    count(w.Essn) as num_Empregados
from 
    project p
join 
    works_on w on p.Pnumber = w.Pno
group by
    p.Pname, p.Plocation
order by 
    num_Empregados desc;
    
select * from projetos_mais_empregados;

-- Lista de Projetos, Departamentos e Gerentes
create view lista_projetos_dept_gerentes as 
select 
    p.Pname as Projeto, 
    d.Dname as Departamento, 
    concat(e.Fname, ' ', e.Lname) as Gerente
from 
    project p
join 
    departament d on p.Dnum = d.Dnumber
join 
    employee e on d.Mgr_ssn = e.Ssn;
    
select * from lista_projetos_dept_gerentes;

-- Quais empregados possuem dependentes e se são gerentes 
create view empregados_com_dependentes as 
select 
    concat(e.Fname, ' ', e.Lname) as Empregado, 
    d.Dependent_name as Dependente, 
    if(e.Ssn = dept.Mgr_ssn, 'Sim', 'Não') as Gerente
from 
    employee e
left join 
    dependent d on e.Ssn = d.Essn
left join
    departament dept on e.Ssn = dept.Mgr_ssn;

select * from empregados_com_dependentes;

-- Criação de Usuários e Definindo Permissões 

-- usuário gerente
create user 'gerente'@'localhost' identified by 'senha_gerente';
grant select on company.employee to 'gerente'@'localhost';
grant select on company.departament to 'gerente'@'localhost';
grant select on company.num_emp_por_depto_localidade to 'gerente'@'localhost';
grant select on company.lista_dept_gerentes to 'gerente'@'localhost';
grant select on company.projetos_mais_empregados to 'gerente'@'localhost';
grant select on company.lista_projetos_dept_gerentes to 'gerente'@'localhost';
grant select on company.empregados_com_dependentes to 'gerente'@'localhost';

-- usário funcionário não terá acesso as informações relacionadas aos departamentos ou gerentes
create user 'employee'@'localhost' identified by 'senha_employee';
grant select on company.empregados_com_dependentes to 'employee'@'localhost';

