create database University_HR_ManagementSystem_Team_110

go 

use University_HR_ManagementSystem_Team_110

--CHECK ROLE SALARY WITH TA
go
create function calculatesalary(@employee_ID int)
returns decimal(10,2)
as
begin
declare @salary decimal(10,2), @base_salary decimal(10,2), @yoe int,@yoep decimal(4,2);

select top 1 @base_salary = r.base_salary , @yoep = r.percentage_YOE
from Employee_Role er inner join Role r on er.role_name = r.role_name
where er.emp_ID = @employee_ID 
order by r.rank asc;

select @yoe=e.years_of_experience
from Employee e
where e.employee_ID=@employee_ID

set @salary = @base_salary + ( (@yoep/100)*(@yoe*@base_salary) )
return @salary
end

go 
create function final_approval (@request_ID int )
returns varchar(50)
as
begin
    declare @status varchar(50);
    if exists (
        select 1 
        from employee_approve_leave
        where leave_id = @request_id
        and status = 'rejected'
    )
        set @status = 'rejected'
    else
    begin
    if exists (
        select 1 
        from employee_approve_leave
        where leave_id = @request_id
        and status = 'pending')

        set @status = 'pending'
        
        else
         set @status = 'approved'
end
    return @status
end


go
create proc createAllTables
as
create table Department(
name varchar(50) primary key,
building_location varchar(50)
);

create table Employee(
employee_ID int identity(1,1) primary key,
first_name varchar(50),
last_name varchar(50),
email varchar(50),
password varchar(50),
address varchar(50),
gender char(1),
official_day_off varchar(50),
years_of_experience int,
national_ID char(16), 
employment_status varchar (50) check (employment_status in ('active','onleave','notice_period','resigned')), 
type_of_contract varchar (50) check (type_of_contract in ('full_time','part_time')),
emergency_contact_name varchar (50), 
emergency_contact_phone char (11),
annual_balance int,
accidental_balance int,
salary as dbo.calculatesalary(employee_ID),
hire_date date,
last_working_date date,
dept_name varchar (50),
foreign key (dept_name) references Department
);

create table Employee_Phone(
emp_ID int, 
phone_num char(11),
foreign key (emp_ID) references Employee,
primary key(emp_ID,phone_num)
);

create table Role(
role_name varchar (50) primary key,
title varchar (50),
description varchar (50),
rank int, 
base_salary decimal (10,2),
percentage_YOE decimal (4,2),
percentage_overtime decimal (4,2),
annual_balance int,
accidental_balance int
);

create table Employee_Role(
emp_ID int,
role_name varchar (50),
foreign key (emp_ID) references Employee,
foreign key (role_name) references Role,
primary key (emp_ID,role_name)
);

create table Role_existsIn_Department(
department_name varchar(50),
Role_name varchar(50), 
foreign key (department_name) references Department,
foreign key (Role_name) references Role,
primary key (department_name,Role_name)
);

create table Leave(
request_ID int identity(1,1) primary key,
date_of_request date,
start_date date not null,
end_date date not null, 
num_days as (datediff(day,start_date,end_date))+1,
final_approval_status varchar (50) check (final_approval_status in ('approved','rejected','pending')) default 'pending'
);

create table Annual_Leave(
request_ID int,
emp_ID int,
replacement_emp int,
foreign key (emp_ID) references Employee,
foreign key (replacement_emp) references Employee,
foreign key(request_ID) references Leave,
primary key (request_ID)
);

create table Accidental_Leave(
request_ID int,
emp_ID int,
foreign key (emp_ID) references Employee,
foreign key(request_ID) references Leave,
primary key (request_ID)
);

create table Medical_Leave(
request_ID int,
insurance_status BIT,
disability_details varchar (50),
type varchar (50) check (type in ('sick','maternity')) ,
Emp_ID int,
foreign key (request_ID) references Leave,
foreign key (emp_ID) references Employee,
primary key (request_ID)
);

create table Unpaid_Leave(
request_ID int,
emp_ID int,
foreign key (request_ID) references Leave,
foreign key (emp_ID) references Employee,
primary key (request_ID)
);

create table Compensation_Leave(
request_ID int,
reason varchar (50), 
date_of_original_workday date,
emp_ID int,
replacement_emp int,
foreign key (request_ID) references Leave,
foreign key (emp_ID) references Employee,
foreign key (replacement_emp)  references Employee,
primary key (request_ID)
);

create table Document(
document_ID int identity(1,1) primary key,
type varchar (50),
description varchar (50),
file_name varchar (50),
creation_date date,
expiry_date date,
status varchar (50) check (status in ('valid','expired')),
emp_ID int, 
medical_ID int,
unpaid_ID int,
foreign key (emp_ID) references Employee,
foreign key (medical_ID) references medical_leave,
foreign key (unpaid_ID) references unpaid_leave 
);

create table payroll(
ID int identity(1,1) primary key,
payment_date date,
final_salary_amount decimal (10,1),
from_date date,
to_date date,
comments varchar (150),
bonus_amount decimal (10,2),
deductions_amount decimal (10,2),
emp_ID int,
foreign key (emp_ID) references Employee
);

create table Attendance(
attendance_ID int identity(1,1) primary key,
 date date,
 check_in_time time,
 check_out_time time,
 total_duration as (datediff(minute,check_in_time,check_out_time)),
 status varchar (50) check (status in ('absent','attended')) default 'absent',
 emp_ID int,
 foreign key (emp_ID) references Employee
)

create table Deduction(
deduction_ID int identity(1,1),
emp_ID int,
date date,
amount decimal (10,2),
type varchar (50) check (type in ('unpaid','missing_hours','missing_days')),
status varchar (50) default 'pending' check (status in ('pending','finalized')),
unpaid_ID int,
attendance_ID int,
foreign key (emp_ID) references Employee,
foreign key (unpaid_ID) references Unpaid_leave,
foreign key (attendance_ID) references attendance,
primary key (deduction_ID,emp_ID)
);

create table Performance(
performance_ID int identity(1,1) primary key,
rating int check (rating between 1 and 5), 
comments varchar (50),
semester char (3),
emp_ID int,
foreign key (emp_ID) references Employee
);

create table Employee_Replace_Employee(
Table_ID int identity(1,1),
Emp1_ID int,
Emp2_ID int,
from_date date,
to_date date,
foreign key (Emp1_ID) references Employee,
foreign key (Emp2_ID) references Employee,
primary key (Emp1_ID,Emp2_ID,Table_ID)
);

create table Employee_Approve_Leave(
Emp1_ID int,
Leave_ID int,
status varchar (50),
foreign key (Emp1_ID) references Employee,
foreign key (Leave_ID) references Leave,
primary key (Emp1_ID,Leave_ID)
);
go

go 
create proc dropAllTables
as
drop table Employee_Approve_Leave;
drop table Employee_Replace_Employee;

drop table Performance;
drop table Deduction;

drop table Attendance;
drop table Payroll;
drop table Document;

drop table Compensation_Leave;
drop table Unpaid_Leave;
drop table Medical_Leave;
drop table Accidental_Leave;
drop table Annual_Leave;
drop table Leave;

drop table Role_existsIn_Department;
drop table Employee_Role;
drop table Employee_Phone;

drop table Employee;

drop table Role;
drop table Department;


go 
create proc  dropAllProceduresFunctionsViews 
as
drop proc createAllTables;
drop proc dropAllTables;
drop proc clearAllTables;
drop view allEmployeeProfiles;
drop view  NoEmployeeDept;
drop view  allPerformance ;
drop view  allRejectedMedicals;
drop view  allEmployeeAttendance ;
drop proc Update_Status_Doc;
drop proc  Remove_Deductions;
drop proc Update_Employment_Status;
drop proc Create_Holiday;
drop proc Add_Holiday;
drop proc Initiate_Attendance;
drop proc  Update_Attendance;
drop proc  Remove_Holiday;
drop proc Remove_DayOff;
drop proc Remove_Approved_Leaves;
drop proc Replace_employee;
drop function HRLoginValidation;
drop proc HR_approval_an_acc;
drop proc  HR_approval_unpaid;
drop proc HR_approval_comp;
drop proc  Deduction_hours;
drop proc  Deduction_days;
drop proc Deduction_unpaid;
drop function Bonus_amount;
drop proc Add_Payroll;
drop function EmployeeLoginValidation;
drop function MyPerformance;
drop function MyAttendance;
drop function Last_month_payroll;
drop function Deductions_Attendance;
drop function Is_On_Leave;
drop proc Submit_annual;
drop function Status_leaves;
drop proc Upperboard_approve_annual;
drop proc Submit_accidental;
drop proc Submit_medical;
drop proc Submit_unpaid;
drop proc Upperboard_approve_unpaids;
drop proc Submit_compensation;
drop proc Dean_andHR_Evaluation;
drop function calculatesalary;
drop function final_approval;
go

go 
create proc clearAllTables
as
delete from Employee_Approve_Leave;
delete from Employee_Replace_Employee;

delete from Performance;
delete from Deduction;

delete from Attendance;
delete from Payroll;
delete from Document;

delete from Compensation_Leave;
delete from Unpaid_Leave;
delete from Medical_Leave;
delete from Accidental_Leave;
delete from Annual_Leave;
delete from Leave;

delete from Role_existsIn_Department;
delete from Employee_Role;
delete from Employee_Phone;

delete from Employee;

delete from Role;
delete from Department;
go 
go
create view allEmployeeProfiles 
as 
select  employee_ID, first_name, last_name, gender, email, address, years_of_experience, 
official_day_off,type_of_contract,employment_status, annual_balance, accidental_balance
from Employee
go 

go 
create view  NoEmployeeDept 
as 
select count(employee_ID) as number_of_employees, dept_name
from Employee
where dept_name is not null
group by dept_name
go 

create view allPerformance 
as
select *
from Performance
where semester like 'W%'

go 
create view allRejectedMedicals
as
select M.*
from Medical_Leave M, Leave L
where L.request_id=M.request_id and L.final_approval_status = 'rejected'

go
create view allEmployeeAttendance
as 
select *
from Attendance 
where (datediff(day,date,getdate())) = 1
go

create proc Update_Status_Doc 
as
update Document
set status ='expired'
where (cast(getdate() as date))>expiry_date
go 

create proc Remove_Deductions 
as
delete D
from Deduction D
inner join Employee E on D.emp_ID=E.employee_ID
where E.employment_status='resigned'
go

create proc Update_Employment_Status
@Employee_ID int 
as
declare @is_on_leave bit 
set @is_on_leave = dbo.Is_On_Leave(@Employee_ID, cast(getdate() as date), cast(getdate() as date)) 
begin
if @is_on_leave=0
begin
update Employee 
set employment_status='active'
where employee_ID=@Employee_ID
end
else 
begin
update Employee 
set employment_status='onleave'
where employee_ID=@Employee_ID
end
end

go
create proc Create_Holiday
as 
create table  Holiday (
holiday_id int identity(1,1) primary key,
name varchar(50),
from_date date,
to_date date
);
go
create proc Add_Holiday 
@holiday_name varchar(50),
@from_date date,
@to_date date
as 
insert into Holiday (name,from_date,to_date) values(@holiday_name,@from_date,@to_date);


go 
create proc Initiate_Attendance 
as
insert into Attendance(emp_ID,date) 
select Employee_ID, cast(getdate() as date) from Employee 



go
create proc  Update_Attendance 
@Employee_id int,
@check_in time ,
@check_out time
as 
 UPDATE Attendance
    SET check_in_time = @check_in,
        check_out_time = @check_out,
        status = 'attended'
    WHERE emp_ID = @Employee_id
      AND date =cast(getdate() as date);

go 
create proc Remove_Holiday 
as
delete A
from Attendance A inner join Holiday H 
on A.date between H.from_date and H.to_date 

go 
create proc Remove_DayOff
@Employee_id int 
as 
delete A 
from Attendance A 
inner join Employee E on E.Employee_ID = A.emp_ID 
where A.emp_ID=@Employee_id and A.status='absent' and datename(weekday,A.date)=E.official_day_off and month(A.date)=month(getdate()) and year(A.date)=year(getdate())
   
go 
create proc Remove_Approved_Leaves
@Employee_id int 
as 

delete A 
from Attendance A 
join  Leave L on A.date between L.start_date and L.end_date
join Annual_Leave al ON l.request_ID = al.request_ID
where al.emp_ID = @Employee_id and A.emp_ID = @Employee_id and l.final_approval_status = 'approved' and A.status='absent';
    
delete a from Attendance A
join Leave l on a.date between l.start_date and  l.end_date
join Accidental_Leave acl on l.request_ID = acl.request_ID
where  acl.emp_ID = @Employee_id and A.emp_ID = @Employee_id and  l.final_approval_status = 'approved'and  A.status='absent';
    
delete a from Attendance A
join Leave l on a.date between l.start_date and  l.end_date
join Medical_Leave ml on l.request_ID = ml.request_ID
where  ml.emp_ID = @Employee_id and A.emp_ID = @Employee_id and   l.final_approval_status = 'approved'and  A.status='absent';
    
delete a from Attendance A
join Leave l on a.date between l.start_date and  l.end_date
join Unpaid_Leave ul on l.request_ID = ul.request_ID
where  ul.emp_ID = @Employee_id and A.emp_ID = @Employee_id and l.final_approval_status = 'approved' and  A.status='absent';
    
delete a from Attendance A
join Leave l on a.date between  l.start_date and l.end_date
join Compensation_Leave cl on l.request_ID = cl.request_ID
where cl.emp_ID = @Employee_id and A.emp_ID = @Employee_id and l.final_approval_status = 'approved'and  A.status='absent';



go 
create proc Replace_employee
@Emp1_ID int,
@Emp2_ID int,
@from_date date,
@to_date date 
as
insert into  Employee_replace_employee(Emp1_ID,Emp2_ID ,from_date,to_date)
values (@Emp1_ID ,@Emp2_ID ,@from_date ,@to_date  )
go 

create function HRLoginValidation(@employee_ID int, @password varchar(50))
returns bit
as
Begin
return case when exists (
        select * from Employee E
        join Employee_Role ER on ER.emp_ID=E.employee_ID
        where employee_ID = @employee_ID and password = @password and ER.role_name like 'HR%'
    )then 1 else 0 
    end;
end;
go
create proc HR_approval_an_acc 
@request_ID int,
@HR_ID int 
as 
declare @an int, @ac int, @num_days int,  @start_date date , @end_date date , @two_days bit, @eid int

if exists(
select 1
from Employee_Approve_Leave AL inner join Leave L on AL.Leave_ID = L.request_ID
 where AL.Leave_ID= @request_ID and ((day(L.date_of_request)- day(@start_date)) <= 2))
 set @two_days =1
 else 
  set @two_days =0

select @num_days = num_days from Leave 
where request_ID = @request_ID

select @eid = e.employee_ID, @an=annual_balance , @start_date=start_date,@end_date=end_date
from Employee E ,Leave L, Annual_Leave AL
where E.Employee_ID=AL.emp_ID and @request_ID=AL.request_ID and L.request_ID=AL.request_ID

select @eid = e.employee_ID,@ac=accidental_balance
from Employee E ,Leave L, Accidental_Leave AC
where E.Employee_ID=AC.emp_ID and @request_ID=AC.request_ID and  L.request_ID=AC.request_ID

   

if  (@an>=@num_days) or (@ac>=@num_days and @num_days=1 and @two_days =1)
 begin 
    update Employee_Approve_Leave
    set status='approved'
    where @HR_ID=emp1_ID and @request_ID=Leave_ID
    update Leave
    set final_approval_status=dbo.final_approval(@request_ID)
    where @request_ID=request_ID
    if(@an is null)
        begin
        if (dbo.final_approval(@request_ID)='approved')
            begin
                update Employee
                set accidental_balance=accidental_balance-@num_days
                where employee_ID=@eid
            end
        end
    else 
        begin
        if (dbo.final_approval(@request_ID)='approved')
            begin
                update Employee
                set accidental_balance=annual_balance-@num_days
                where employee_ID=@eid
            end
        end
 end 
 else 
 begin
  update Employee_Approve_Leave
 set status='rejected'
 where @HR_ID=emp1_ID and @request_ID=Leave_ID
  update Leave
 set final_approval_status=dbo.final_approval(@request_ID)
 where @request_ID=request_ID
 end


 
 go 
 create proc HR_approval_unpaid
 @request_ID int,
 @HR_ID int 
 as 
 declare @num_days int , @count int, @e int

 select @num_days = num_days
 from Leave L
 where request_ID = @request_ID

 select @e=ul.emp_ID
 from Unpaid_Leave UL
 where request_ID = @request_ID

 select @count=count(L.request_ID)
 from Leave L, Unpaid_Leave UL
 where l.request_ID=ul.request_ID and ul.emp_ID=@e and l.request_ID<>@request_ID and l.final_approval_status='approved'


 if @num_days<=30 and @count=0
 begin
  update Employee_Approve_Leave
 set status='approved'
 where @HR_ID=emp1_ID and @request_ID=Leave_ID
  update Leave
 set final_approval_status=dbo.final_approval(@request_ID)
 where @request_ID=request_ID
 end 
 else 
 begin
  update Employee_Approve_Leave
 set status='rejected'
 where @HR_ID=emp1_ID and @request_ID=Leave_ID
  update Leave
 set final_approval_status=dbo.final_approval(@request_ID)
 where @request_ID=request_ID
 end 


go
create proc HR_approval_comp
@request_ID int, 
@HR_ID int
as
declare @duration int, @original date , @d int ,@employee_ID int,  @is_replaced bit ,@start_date date ,@end_date date , @eid2 int, @table1 int, @busy bit
 
select @duration=(A.total_duration/60), @original =CL.date_of_original_workday, @d=month(L.date_of_request),@employee_ID= E.employee_ID,@start_date =L.start_date,@end_date =L.end_date
from Attendance A, Compensation_Leave CL, Leave L ,Employee E 
where A.emp_ID = CL.emp_ID and @request_ID = CL.request_ID and @request_ID = L.request_ID and (A.total_duration/60)>=8
 and CL.date_of_original_workday = A.date and A.status='attended' and Cl.emp_ID=E.employee_ID and DateName(weekday,CL.date_of_original_workday)=E.official_day_off
 

   select @eid2=CL.replacement_emp from Compensation_Leave CL where CL.request_ID=@request_ID

   if exists ( select 1 from Employee_Replace_Employee er
               where (er.Emp2_ID = @eid2)  and (@start_date>= er.from_date and @end_date<= er.to_date))
              set  @busy = 1 
              else 
              set @busy = 0


   if ((@eid2 is not null) and ( @busy = 0 ) and dbo.Is_On_Leave(@eid2, @start_date, @end_date) = 0)
            set @is_replaced=1 
        else 
          set @is_replaced=0

if (month(@original) = @d and (@end_date=@start_date) and (@duration>=8) and @is_replaced=1 )
begin
  update Employee_Approve_Leave
 set status='approved'
 where @HR_ID=emp1_ID and @request_ID=Leave_ID
  update Leave
 set final_approval_status=dbo.final_approval(@request_ID)
 where @request_ID=request_ID

 insert into Employee_Replace_Employee(Emp1_ID,Emp2_ID,from_date,to_date)
 values(@employee_ID,@eid2,@start_date,@end_date)
 end 
 else
 begin
   update Employee_Approve_Leave
 set status='rejected'
 where @HR_ID=emp1_ID and @request_ID=Leave_ID
  update Leave
 set final_approval_status=dbo.final_approval(@request_ID)
 where @request_ID=request_ID
 end 

 go
 create proc Deduction_hours
 @employee_ID int
 as
 declare @duration int, @A int, @date date, @salary decimal(10,2), @rate decimal(10,2), @amount decimal(10,2)

 select top 1 @duration = (A.total_duration/60) , @A=attendance_ID, @date=A.date
 from Attendance A
 where @employee_ID=A.emp_ID and (A.total_duration/60)<8 and month(A.date)=month(getdate())
 order by A.date asc

 select @salary = salary 
 from Employee 
 where employee_ID = @employee_ID;

 set @rate = (@salary / 22) / 8;
 set @amount = @rate * (8 - @duration);


 insert into deduction(emp_ID,date,amount,type,attendance_ID)
 values(@employee_ID,@date,@amount,'missing_hours',@A)

 go

 create proc Deduction_days
 @employee_ID int
 as
 begin
 declare @attendance_ID int, @absent_date date, @salary decimal(10,2), @rate decimal(10,2), @amount decimal(10,2);
    set @salary=0;

    select @salary = salary 
    from Employee 
    where employee_ID = @employee_ID;

    set @rate = (@salary / 22) / 8;


    declare absent_cursor cursor for
        select attendance_ID, date
        from dbo.MyAttendance(@employee_ID)
        where emp_ID = @employee_ID
          and status = 'absent' and month(date) = month(getdate()) and year(date)  = year(getdate());

    open absent_cursor;

    fetch next from absent_cursor into @attendance_ID, @absent_date;

    while @@FETCH_STATUS = 0
    begin
        set @amount = @rate * 8;

        insert into Deduction(emp_ID, date, amount, type, status, attendance_ID)
        values (@employee_ID, @absent_date, @amount, 'missing_days', 'pending', @attendance_ID);

        fetch next from absent_cursor into @attendance_ID, @absent_date;
    end

    close absent_cursor;
    deallocate absent_cursor;
end
go
 
go

create proc Deduction_unpaid
@employee_ID int 
as
declare @rate decimal(10,2), @salary decimal(10,2), @start_date date,@end_date date,@date date,@Unpaid_id int

select top 1 @start_date=start_date , @end_date=end_date, @Unpaid_id=UL.request_ID
from Leave L inner join Unpaid_Leave UL on L.request_ID=UL.request_ID 
where UL.Emp_ID=@employee_ID and L.final_approval_status='approved'
order by L.start_date desc

select @salary=salary from Employee where @employee_ID=employee_ID
set @rate = (@salary / 22) / 8;

declare @m1 int, @m2 int, @deduction1 decimal(10,2), @deduction2 decimal(10,2), @deduction_amount decimal(10,2)

if (month(@start_date) <> month(@end_date) and (year(@start_date)=year(@end_date)) and (@Unpaid_id is not null))
    begin
        set @m1 = day(EOMONTH(@start_date)) - day(@start_date) + 1
        set @m2 = day(@end_date)

        set @deduction1 = @rate*8*@m1
        set @deduction2 = @rate*8*@m2

        insert into Deduction(emp_ID,date,amount,type,unpaid_ID)
        values(@employee_ID,cast(getdate() as date),@deduction1,'unpaid',@Unpaid_id)

        insert into Deduction(emp_ID,date,amount,type,unpaid_ID)
        values(@employee_ID,cast(getdate() as date),@deduction2,'unpaid',@Unpaid_id)
    end
else
    begin
        if (@Unpaid_id is not null)
        begin
            set @deduction_amount = @rate*8*((day(@end_date)-day(@start_date))+1)

            insert into Deduction(emp_ID,date,amount,type,unpaid_ID)
            values(@employee_ID,cast(getdate() as date),@deduction_amount,'unpaid',@Unpaid_id)
        end
    end



go 
create function Bonus_amount (@employee_ID int)
returns decimal(10,2)
as
begin
    declare @bonus decimal(10,2), @overtime_factor decimal(4,2), @extra_hours decimal(10,2), @rate decimal(10,2), @salary decimal(10,2);
    set @bonus=0;
    set @overtime_factor=0;
    set @extra_hours=0;
    set @rate=0;
    set @salary=0;

    select @salary = salary from Employee where employee_ID = @employee_ID;
    set @rate = (@salary / 22) / 8;
    
    select top 1 @overtime_factor = r.percentage_overtime 
    from Employee_Role er inner join Role r on er.role_name = r.role_name
    where er.emp_ID = @employee_ID 
    order by r.rank asc;
    

    select @extra_hours = sum(case when (total_duration/60) > 8 then (total_duration/60) - 8 else 0 end) 
    from Attendance
    where emp_ID = @employee_ID and month(date) = month(getdate()) and year(date) = year(getdate());
    
    set @bonus = @rate * (@overtime_factor / 100) * @extra_hours;
    return @bonus;
end;


go

create proc Add_Payroll
@employee_ID int, 
@from date, 
@to date 
as
declare @s decimal(10,2) , @b decimal(10,2), @d decimal(10,2), @final_salary decimal(10,2)


select @d=sum(d.amount)
from Deduction d
where d.emp_ID=@employee_ID and d.date>=@from and d.date<=@to and d.status<>'finalized'

set @s=dbo.calculatesalary(@employee_ID)
set @b=dbo.Bonus_amount(@employee_ID)

if (@d is null) set @d=0
if (@b is null) set @b=0

set @final_salary=(@s + @b) - @d

insert into Payroll(payment_date,final_salary_amount,from_date,to_date,bonus_amount,deductions_amount,emp_ID)
values(cast(getdate() as date),@final_salary,@from,@to,@b,@d,@employee_ID)

update Deduction 
set status='finalized'
where emp_ID=@employee_ID

go

create function EmployeeLoginValidation(@employee_ID int, @password varchar(50))
returns bit
as
Begin
return case when exists (
        select * from Employee
        where employee_ID = @employee_ID and password = @password
    )then 1 else 0 
    end;
    end;

    go
create function MyPerformance(@employee_ID int, @semester char(3))
returns table
as
return(select performance_ID, rating, comments
       from Performance 
       where emp_ID = @employee_ID and semester = @semester);

go

create function MyAttendance(@employee_ID int )
returns table
as 
return (select * 
        from Attendance 
        where emp_ID = @employee_ID  and month(date) = month(getdate()) and Year(date) = Year(getdate()) and 
        NOT (status = 'absent' AND DATENAME(weekday, date) = (SELECT official_day_off FROM Employee WHERE employee_ID = @employee_ID))
        );
go

create function  Last_month_payroll(@employee_ID int)
returns table
as
return(select * 
       from Payroll 
       where emp_ID = @employee_ID and datediff(Month, payment_date,getdate()) = 1)

go

create function  Deductions_Attendance(@employee_ID int, @month int)
returns table
as
return(select * 
       from Deduction
       where emp_ID = @employee_ID and month(date) = @month and type like 'missing%')


go
create function Is_On_Leave (@employee_ID int, @from date, @to date)
returns bit
as
begin
    return case when exists (select 1
            from Leave l
            where ((l.final_approval_status = 'approved') or (l.final_approval_status = 'pending'))
              and l.start_date <= @to and l.end_date >= @from
              and (
                    exists (select 1 from Annual_Leave al where al.request_ID = l.request_ID and al.emp_ID = @employee_ID)
                 or exists (select 1 from Accidental_Leave acl where acl.request_ID = l.request_ID and acl.emp_ID = @employee_ID)
                 or exists (select 1 from Medical_Leave ml where ml.request_ID = l.request_ID and ml.emp_ID = @employee_ID)
                 or exists (select 1 from Unpaid_Leave ul where ul.request_ID = l.request_ID and ul.emp_ID = @employee_ID)
                 or exists (select 1 from Compensation_Leave cl where cl.request_ID = l.request_ID and cl.emp_ID = @employee_ID)
                 )
      
    ) then 1 else 0 end;
end;
go


create proc  Submit_annual 
@employee_ID int,
@replacement_emp int,
@start_date date, 
@end_date date
as
declare @request_ID int ,@type_of_contract varchar(50), @employee_dept varchar(50),@employee_role varchar(50),@employee_rank int

select @type_of_contract = type_of_contract
from Employee where Employee_ID=@employee_ID

select @employee_dept = dept_name from Employee where employee_ID = @employee_ID;


select top 1 @employee_role = er.role_name , @employee_rank=r.rank
from Employee_Role er , Role r
where er.role_name=r.role_name and er.emp_ID = @employee_ID
order by r.rank asc


if (@type_of_contract='full_time')
begin 

insert into Leave(date_of_request,start_date,end_date)
values(cast(getdate() as date),@start_date,@end_date )
set @request_ID = scope_identity()

insert into Annual_Leave(request_ID,emp_ID,replacement_emp)
values(@request_ID,@employee_ID,@replacement_emp)

if  (@employee_role = 'dean' or @employee_role = 'Vice Dean'  )
begin
    insert into employee_approve_leave (emp1_id, leave_id, status)
    select employee_id, @request_id, 'pending'
    from employee e
    inner join employee_role er on e.employee_id = er.emp_id
    where er.role_name = 'president';

    declare @hr_id int, @hr_id2 int

    select @hr_id=e.employee_id
    from employee e
    inner join employee_role er on e.employee_id = er.emp_id
    where er.role_name like 'hr%' and er.role_name like '%' + @employee_dept;

    if(dbo.Is_On_Leave(@hr_id,cast(getdate() as date),cast(getdate() as date)) = 1)
        begin
            select @hr_id2=er.Emp2_ID from Employee_Replace_Employee er where (er.Emp1_ID=@hr_id and getdate() >= er.from_date and getdate() <= er.to_date)
            
            insert into employee_approve_leave (emp1_id, leave_id, status)
            values(@hr_id2, @request_ID, 'pending')

        end
    else 
        begin
        insert into employee_approve_leave (emp1_id, leave_id, status)
        values(@hr_id,@request_ID,'pending')
        end

end
else if (@employee_dept = 'hr')
begin
    
    declare @hr_manager int,@hr_manager2 int
    select @hr_manager=e.employee_id
    from employee e
    inner join employee_role er on e.employee_id = er.emp_id
    where( er.role_name like 'hr manager') 

    if(dbo.Is_On_Leave(@hr_id,cast(getdate() as date),cast(getdate() as date)) = 1)
       begin
            select @hr_manager2=er.Emp2_ID from Employee_Replace_Employee er where (er.Emp1_ID=@hr_manager and getdate() >= er.from_date and getdate() <= er.to_date)
            insert into employee_approve_leave (emp1_id, leave_id, status)
            values(@hr_manager2, @request_ID, 'pending')
       end
    else
        begin
            insert into employee_approve_leave (emp1_id, leave_id, status)
            values(@hr_manager, @request_ID, 'pending')
        end
end
else
begin
    declare @dean_id int;
    select @dean_id=e.employee_ID
    from employee e inner join employee_role er on e.employee_id = er.emp_id
    where er.role_name = 'dean' and e.dept_name = @employee_dept;

    if (dbo.Is_On_Leave(@dean_id,cast(getdate() as date),cast(getdate() as date)) = 0)
        begin
            insert into employee_approve_leave (emp1_id, leave_id, status)
            values(@dean_id, @request_id, 'pending')
        end
     else
     begin
        declare @vice_dean_id int;
        select @vice_dean_id=e.employee_ID
        from employee e inner join employee_role er on e.employee_id = er.emp_id
        where er.role_name = 'Vice Dean' and e.dept_name = @employee_dept;

        insert into employee_approve_leave (emp1_id, leave_id, status)
        values(@vice_dean_id, @request_id, 'pending')
     end   

    declare @hr_id3 int, @hr_id4 int

    select @hr_id3=e.employee_id
    from employee e
    inner join employee_role er on e.employee_id = er.emp_id
    where er.role_name like 'hr%' and er.role_name like '%' + @employee_dept;

    if (dbo.Is_On_Leave(@hr_id3,cast(getdate() as date),cast(getdate() as date)) = 1)
    begin
        select @hr_id4=er.Emp2_ID from Employee_Replace_Employee er where (er.Emp1_ID=@hr_manager and getdate() >= er.from_date and getdate() <= er.to_date)
        insert into employee_approve_leave (emp1_id, leave_id, status)
        values(@hr_id4, @request_ID, 'pending')
    end
    else
    begin
        insert into employee_approve_leave (emp1_id, leave_id, status)
        values(@hr_id3,@request_ID,'pending')
    end
end

    



end 

 go

 create function  Status_leaves(@employee_ID int)
 returns table
 as
 return (select L.request_ID, L.date_of_request, L.final_approval_status
         from Leave L, Annual_Leave A
         where L.request_ID = A.request_ID and A.emp_ID = @employee_ID and Month(L.date_of_request) = Month(getdate()) and Year(L.date_of_request) = Year(getdate())
         UNION
         select L.request_ID, L.date_of_request, L.final_approval_status
         from Leave L, Accidental_Leave AC
         where L.request_ID = AC.request_ID and AC.emp_ID = @employee_ID and Month(L.date_of_request) = Month(getdate()) and Year(L.date_of_request) = Year(getdate()))


 go
 create proc  Upperboard_approve_annual
  @request_ID int, 
  @Upperboard_ID int,
  @replacement_ID int 
  as
  declare @is_on_leave bit, @start date, @end date, @dep1 varchar(50), @dep2 varchar(50), @empID int, @deanorvice_id int, @table1 int, @busy bit , @is_replaced bit
   
  select @start = start_date
  from Leave 
  where request_ID = @request_ID

  select @end = end_date
  from Leave 
  where request_ID = @request_ID

  set @is_on_leave = dbo.Is_On_Leave (@replacement_ID, @start, @end)


  select @empID= emp_ID
  from Annual_Leave
  where @request_ID= request_ID

  select @dep1 = dept_name 
  from Employee
  where @replacement_ID= employee_ID

  select @dep2 = dept_name
  from Employee
  where @empID= employee_ID



   if exists ( select 1 from Employee_Replace_Employee er
               where (er.Emp2_ID = @replacement_ID) and (@start>= er.from_date and @end<= er.to_date))
              set  @busy = 1 
              else 
              set @busy = 0


   if ((@replacement_ID is not null) and ( @busy = 0 ))
            set @is_replaced=1 
        else 
          set @is_replaced=0


  if (@dep1 = @dep2) and (@is_on_leave = 0) and @is_replaced=1
  begin
        update Employee_Approve_Leave
        set status = 'approved'
        where Emp1_ID = @Upperboard_ID and Leave_ID = @request_ID

        update Leave
        set final_approval_status = dbo.final_approval(@request_ID)
        where  request_ID = @request_ID

        insert into Employee_Replace_Employee(Emp1_ID,Emp2_ID,from_date,to_date)
        values(@empID,@replacement_ID,@start,@end)
  end
  else
  begin
        update Employee_Approve_Leave
        set status = 'rejected'
        where Emp1_ID = @Upperboard_ID and Leave_ID = @request_ID

        update Leave
        set final_approval_status = dbo.final_approval(@request_ID)
        where  request_ID = @request_ID
  end

go 
create proc Submit_accidental
  @employee_ID int,
  @start_date date, 
  @end_date date
  as
  declare @request_ID int,@employee_dept varchar(50), @hr_id int, @hr_id2 int

insert into Leave(date_of_request,start_date,end_date)
values(cast(getdate() as date),@start_date,@end_date )
set @request_ID = scope_identity()

insert into Accidental_Leave(request_ID,emp_ID)
values(@request_ID,@employee_ID)

select @employee_dept = dept_name from Employee where employee_ID = @employee_ID;

select @hr_id=E.employee_ID
from Employee E inner join Employee_Role ER on E.employee_ID = ER.emp_ID
where (ER.role_name LIKE 'HR%') and (er.role_name like '%' + @employee_dept)

if(dbo.Is_On_Leave(@hr_id,cast(getdate() as date),cast(getdate() as date)) = 1)
begin
    select @hr_id2=er.Emp2_ID from Employee_Replace_Employee er where (er.Emp1_ID=@hr_id and getdate() >= er.from_date and getdate() <= er.to_date)
    insert into employee_approve_leave (emp1_id, leave_id, status)
    values(@hr_id2, @request_ID, 'pending')
end
else
begin
    insert into Employee_Approve_Leave (Emp1_ID, Leave_ID, status)
    values(@hr_id,@request_ID,'pending')
end

go 

create proc Submit_medical
@employee_ID int,
@start_date date, 
@end_date date, 
@type varchar(50), 
@insurance_status bit,
@disability_details varchar(50),
@document_description varchar(50),
@file_name varchar(50)
as
declare @request_ID int, @gender char(1), @type_of_contract varchar(50) , @emp_dept varchar(50),@hr_id int,@hr_id2 int,@med_id int, @med_id2 int

select @type_of_contract = type_of_contract
from Employee where Employee_ID=@employee_ID

select @emp_dept = dept_name
from employee
where employee_ID = @employee_ID

select @gender = gender from Employee where @employee_ID= employee_ID 
 

if(@type like 'sick%') or ( (@gender = 'F') and (@type like 'Maternity%') and (@type_of_contract='full_time') )
Begin
insert into Leave(date_of_request,start_date,end_date)
values(cast(getdate() as date),@start_date,@end_date )
set @request_ID = scope_identity()

insert into Medical_Leave(request_ID, insurance_status, disability_details,type, emp_ID )
values(@request_ID, @insurance_status,@disability_details,@type ,@employee_ID)


insert into Document(type,description, file_name, creation_date,status,emp_ID,medical_ID)
values('Medical_Report', @document_description, @file_name, cast(getdate() as date),'valid',@employee_ID,@request_ID)





select @hr_id=E.employee_ID
from Employee E inner join Employee_Role ER on E.employee_ID = ER.emp_ID
where (ER.role_name LIKE 'HR%') and (er.role_name like '%' + @emp_dept)

if(dbo.Is_On_Leave(@hr_id,cast(getdate() as date),cast(getdate() as date)) = 1)
begin
    select @hr_id2=er.Emp2_ID from Employee_Replace_Employee er where (er.Emp1_ID=@hr_id and getdate() >= er.from_date and getdate() <= er.to_date)
    insert into employee_approve_leave (emp1_id, leave_id, status)
    values(@hr_id2, @request_ID, 'pending')
end
else
begin
    insert into Employee_Approve_Leave (Emp1_ID, Leave_ID, status)
    values(@hr_id,@request_ID,'pending')
end



select @med_id=E.employee_ID
from Employee E inner join Employee_Role ER on E.employee_ID = ER.emp_ID
where (ER.role_name LIKE 'Medical%') 

if(dbo.Is_On_Leave(@med_id,cast(getdate() as date),cast(getdate() as date)) = 1)
begin
    select @med_id2=er.Emp2_ID from Employee_Replace_Employee er where (er.Emp1_ID=@med_id and getdate() >= er.from_date and getdate() <= er.to_date)
    insert into employee_approve_leave (emp1_id, leave_id, status)
    values(@med_id2, @request_ID, 'pending')
end
else
begin
    insert into Employee_Approve_Leave (Emp1_ID, Leave_ID, status)
    values(@med_id,@request_ID,'pending')
end

End


go 
create proc Submit_unpaid 
@employee_ID int,
@start_date date,
@end_date date,
@document_description varchar(50),
@file_name varchar(50)
as
declare @type_of_contract varchar(50) , @request_id int, @upperboard_id1 int,@upperboard_id2 int, @hr_id int,@hr_id2 int, @emp_rank int, @emp_dept varchar(50)
select @type_of_contract = type_of_contract
from Employee where Employee_ID=@employee_ID

if (@type_of_contract='full_time')
begin 

insert into leave(date_of_request, start_date, end_date, final_approval_status)
values (cast(getdate() as date), @start_date, @end_date, 'pending')
set @request_id = scope_identity()

insert into unpaid_leave(request_ID, emp_ID)
values (@request_id, @employee_ID)

insert into document(type, description, file_name, creation_date, status, emp_id, unpaid_id)
values ('memo', @document_description, @file_name, cast(getdate() as date), 'valid', @employee_ID, @request_id)

select top 1 @emp_rank = r.rank
from employee_role er join role r on er.role_name = r.role_name
where er.emp_id = @employee_ID
order by r.rank asc

select @emp_dept = dept_name
from employee
where employee_ID = @employee_ID

select @upperboard_id1 = er.emp_ID
from employee_role er join role r on er.role_name = r.role_name
where r.rank = 1

select @upperboard_id2 = er.emp_ID
from employee_role er join role r on er.role_name = r.role_name
where r.rank = 2

select top 1 @hr_id = er.emp_id
from employee_role er join role r on er.role_name = r.role_name join employee e on er.emp_id = e.employee_id
where r.rank = 4 and e.dept_name like 'HR%' and er.role_name like '%' + @emp_dept

if(dbo.Is_On_Leave(@hr_id,getdate(),getdate())=1)
begin
    select @hr_id2=er.Emp2_ID  from Employee_Replace_Employee er where(er.Emp1_ID=@hr_id and getdate() >= er.from_date and getdate() <= er.to_date)
end

if ((@emp_rank = 3 or @emp_rank = 4 ) and @emp_dept<>'hr')
begin
    insert into employee_approve_leave(emp1_id, leave_id, status)
    values (@upperboard_id1, @request_id, 'pending')

    if(dbo.Is_On_Leave(@hr_id,getdate(),getdate())=1)
    begin
    insert into employee_approve_leave(emp1_id, leave_id, status)
    values (@hr_id2, @request_id, 'pending')
    end
    else
    begin
    insert into employee_approve_leave(emp1_id, leave_id, status)
    values (@hr_id, @request_id, 'pending')
    end
end

else if @emp_dept like 'hr%'
begin
    insert into employee_approve_leave(emp1_id, leave_id, status)
    values (@upperboard_id1, @request_id, 'pending')

    insert into employee_approve_leave(emp1_id, leave_id, status)
    values ((select top 1 er.emp_id from employee_role er
             join role r on er.role_name = r.role_name
             join employee e on er.emp_id = e.employee_id
             where r.rank = 3 and e.dept_name like 'hr%'),
            @request_id,
            'pending')
end

else        
begin
    if(dbo.Is_On_Leave(@hr_id,getdate(),getdate())=1)
    begin
    insert into employee_approve_leave(emp1_id, leave_id, status)
    values (@hr_id2, @request_id, 'pending')
    end
    else
    begin
    insert into employee_approve_leave(emp1_id, leave_id, status)
    values (@hr_id, @request_id, 'pending')
    end

    if(dbo.Is_On_Leave(@upperboard_id1,getdate(),getdate())=1)
    begin
    insert into employee_approve_leave(emp1_id, leave_id, status)
    values (@upperboard_id2, @request_id, 'pending')
    end
    else
    begin
    insert into employee_approve_leave(emp1_id, leave_id, status)
    values (@upperboard_id1, @request_id, 'pending')
    end
end

end



go
create proc Upperboard_approve_unpaids 
@request_ID int,
@Upperboard_ID int
as
begin
if exists(select * from Document d where d.unpaid_ID=@request_ID and d.status='valid' and d.type = 'memo' and d.description like '%unpaid%') 
    begin
        update Employee_Approve_Leave
        set status = 'approved'
        where Emp1_ID = @Upperboard_ID and Leave_ID = @request_ID

        update Leave
        set final_approval_status =dbo.final_approval(@request_ID) 
        where  request_ID = @request_ID
    end
else
    begin
        update Employee_Approve_Leave
        set status = 'rejected'
        where Emp1_ID = @Upperboard_ID and Leave_ID = @request_ID

         update Leave
        set final_approval_status = dbo.final_approval(@request_ID)
        where  request_ID = @request_ID
    end
 
 end
go



go 
create proc Submit_compensation 
@employee_ID int, 
@compensation_date date, 
@reason varchar(50), 
@date_of_original_workday date, 
@replacement_emp int
as
declare @request_ID int, @dept varchar(50),@hr_id int, @hr_id2 int

select @dept=e.dept_name
from Employee e
where e.employee_ID=@employee_ID

if(month(@compensation_date) = month(@date_of_original_workday))
begin
insert into Leave(date_of_request,start_date,end_date)
values(cast(getdate() as date),@compensation_date,@compensation_date )
set @request_ID = scope_identity()

insert into Compensation_Leave(request_ID,reason,date_of_original_workday ,emp_ID,replacement_emp)
values(@request_ID,@reason,@date_of_original_workday,@employee_ID,@replacement_emp)

select @hr_id=E.employee_ID
from Employee E inner join Employee_Role ER on E.employee_ID = ER.emp_ID
where (ER.role_name LIKE 'HR%') and (er.role_name like '%' + @dept)

if(dbo.Is_On_Leave(@hr_id,cast(getdate() as date),cast(getdate() as date)) = 1)
begin
    select @hr_id2=er.Emp2_ID from Employee_Replace_Employee er where (er.Emp1_ID=@hr_id and getdate() >= er.from_date and getdate() <= er.to_date)
    insert into employee_approve_leave (emp1_id, leave_id, status)
    values(@hr_id2, @request_ID, 'pending')
end
else
begin
    insert into Employee_Approve_Leave (Emp1_ID, Leave_ID, status)
    values(@hr_id,@request_ID,'pending')
end



end

    


go 
create proc Dean_andHR_Evaluation 
@employee_ID int,
@rating int,
@comment varchar(50), 
@semester char(3) 
as
declare @HR_or_Dean varchar(50), @emp_dep varchar(50), @evaluator_ID int

select @emp_dep=dept_name from Employee where employee_ID=@employee_ID
select @evaluator_ID=emp_ID from Employee_Role where role_name like 'HR%' or role_name like 'Dean%'
select @HR_or_Dean=dept_name from Employee where employee_ID=@evaluator_ID

begin
if @HR_or_Dean=@emp_dep
insert into Performance(rating,comments,semester,emp_ID)
values(@rating,@comment,@semester,@employee_ID)
end

go

