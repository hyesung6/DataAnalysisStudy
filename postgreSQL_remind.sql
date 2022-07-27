select count(*) "��ü�Ǽ�",
	   count(position) "��å�Ǽ�",
	   count(distinct position) "��å����",
	   min(salary) "�ּ�",
	   max(salary) "�ִ�",
	   avg(salary) "���"
from cslee.tb_emp;


select position "��å",
count(*) "�ο���",
min(salary) "�ּ�",
max(salary) "�ִ�",
avg(salary) "���"
from cslee.tb_emp
group by position;

select org_cd "�μ�",
max(salary) "�ִ�"
from cslee.tb_emp
group by org_cd
having min(salary) <= 40000000;

select org_cd, position, avg(salary)
from cslee.tb_emp
where position in ('����', '�븮', '���')
group by org_cd, position;

select org_cd "�μ�",
count(*) "�ο���",
avg(salary) "���"
from cslee.tb_emp
group by org_cd
having count(*) >= 4;

select org_cd,
sum(coalesce((case position when '����' then 1 else 0 end), 0)) "����",
sum(coalesce((case position when '����' then 1 else 0 end), 0)) "����",
sum(coalesce((case position when '�븮' then 1 else 0 end), 0)) "�븮",
sum(coalesce((case position when '���' then 1 else 0 end), 0)) "���"
from cslee.tb_emp
group by org_cd
order by org_cd asc;

-- equi join
select tb_emp.emp_name "�����", tb_org.org_cd "�μ��ڵ�", tb_org.org_name "�μ���"
from cslee.tb_emp, cslee.tb_org
where tb_emp.org_cd = tb_org.org_cd;

-- from���� 2�� �̻��� ���̺��� �ҷ�����,
-- where���� �ҷ��� ���̺����� ������ �����ָ�
-- join�� ������� �ʴ��� join�� ��
select tb_emp.emp_name "�����", tb_org.org_cd "�μ��ڵ�", tb_org.org_name "�μ���"
from cslee.tb_emp, cslee.tb_org
where tb_emp.org_cd = tb_org.org_cd and tb_org.org_name like '����%'
order by tb_emp.emp_name;

--from���� join�� ��������� ����Ͽ� ��ġ��
select tb_emp.emp_name "�����", tb_org.org_cd "�μ��ڵ�", tb_org.org_name "�μ���"
from cslee.tb_emp
join cslee.tb_org 
on tb_emp.org_cd = tb_org.org_cd    -- join ~ on���� join ���� ������ְ�
where tb_org.org_name like '����%'   -- where ������ ��ȸ���̺� ���� ���� ������
order by tb_emp.emp_name desc;      -- ����� �������� ��ȸ

-- ���� ����
-- where �� '=' ����
select ACNT.accno "���¹�ȣ", CUST.cust_name "����", PROD.prod_name "��ǰ��",
ACNT.cont_amt "���ݾ�", EMP.emp_name "����ڸ�"
from cslee.tb_Accnt ACNT, cslee.tb_cust CUST, cslee.tb_prod PROD,
cslee.tb_emp EMP
where ACNT.prod_cd = PROD.prod_cd
and ACNT.cust_no = CUST.cust_no
and ACNT.manager = EMP.emp_no;

select e.emp_name "�����", count(o.org_name) 
from cslee.tb_emp E cross join cslee.tb_org O
group by emp_name, org_name
having emp_name like '��%';

select B.org_cd, B.emp_name, A.org_name
from cslee.tb_org A full outer join cslee.tb_emp B
on A.org_cd = B.org_cd;

select *
from cslee.tb_org A right outer join cslee.tb_org B
on A.org_cd = B.org_cd;

select B.org_cd, B.emp_name, A.org_name
from cslee.tb_org A left outer join cslee.tb_emp B
on A.org_cd = B.org_cd;

select B.org_cd, B.emp_name, A.org_name
from cslee.tb_org A join cslee.tb_emp B
on A.org_cd = B.org_cd;

select B.org_cd, B.emp_name, A.org_name, A.type
from cslee.tb_org A cross join cslee.tb_emp B
order by B asc;

-- ����� cross join
select *
from cslee.tb_org A cross join cslee.tb_emp B;

-- �Ͻ��� cross join
select *
from cslee.tb_org A, cslee.tb_emp B
where A.org_cd  = B.org_cd ;

with tmp as (
select *
from cslee.tb_org A, cslee.tb_emp B
where A.org_cd  = B.org_cd)
select *
from tmp;

select * from cslee.tb_emp;
select * from cslee.tb_org;
select * from cslee.tb_accnt;