-- indices e procedures

use company;
show tables; 

-- criando índice
create INDEX idx_employee_dno on company.employee(Dno);
show index from employee;

-- qual departamento com maior número de pessoas? 
select Dno, count(*) as num_pessoas
	FROM employee
	GROUP BY Dno
	ORDER BY num_pessoas desc
LIMIT 1; 

-- criando índice
create INDEX idx_dept_location_dnumber on company.dept_location(Dnumber);

-- Quais dptos por cidade?
select d.Dname, dl.Dlocation
FROM departament d
JOIN dept_location dl on d.Dnumber = dl.Dnumber;

-- criando índice 
create INDEX idx_employee_dno_lname_fname on company.employee(Dno, Lname, Fname); 

-- Relação de empregados por departamento
select e.Dno, e.Fname, e.Lname
FROM employee e
ORDER BY e.Dno, e.Lname, e.Fname;

-- Procedures

DELIMITER $$

create PROCEDURE ManipulaEmployee(
    in p_acao INT,
    in p_Fname VARCHAR(20),
    in p_Miniti CHAR(1),
    in p_Lname VARCHAR(20),
    in p_SSN CHAR(9),
    in p_Bdate DATE,
    in p_Address VARCHAR(40),
    in p_sex CHAR(1),
    in p_salary DECIMAL(10,2),
    in p_Super_SSN CHAR(9),
    in p_Dno INT
)
begin
    case p_acao
        when 1 then -- Para inserir novo empregado
            insert into company.employee (Fname, Miniti, Lname, SSN, Bdate, Address, sex, salary, Super_SSN, Dno)
            values (p_Fname, p_Miniti, p_Lname, p_SSN, p_Bdate, p_Address, p_sex, p_salary, p_Super_SSN, p_Dno);

        when 2 then -- Atualizar empregado existente
            UPDATE company.employee
            SET Fname = p_Fname, Miniti = p_Miniti, Lname = p_Lname, Bdate = p_Bdate, 
                Address = p_Address, sex = p_sex, salary = p_salary, Super_SSN = p_Super_SSN, Dno = p_Dno
            WHERE SSN = p_SSN;

        when 3 then -- Remover empregado
            DELETE FROM company.employee
            WHERE SSN = p_SSN;

        else -- Ação não reconhecida
            SIGNAL SQLSTATE '45000'
            set MESSAGE_TEXT = 'Ação não reconhecida. Utilize 1 para Inserir, 2 para Atualizar ou 3 para Deletar.';
    end case;
END$$
DELIMITER ;

-- usando 1. Inserir
call ManipulaEmployee(1, 'John', 'D', 'Wick', '123458889', '1980-01-01', '123 Elm St', 'M', 5000.00, '987654321', 1);

-- usando 2. Atualizar
call ManipulaEmployee(2, 'John', 'D', 'Wick', '123458889', '1980-01-01', '456 Oak St', 'M', 5500.00, '987654321', 2);

-- usando 3. Remoer
CALL ManipulaEmployee(3, NULL, NULL, NULL, '123458889', NULL, NULL, NULL, NULL, NULL, NULL);