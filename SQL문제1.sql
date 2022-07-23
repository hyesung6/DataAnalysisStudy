-- tb_emp ���̺��� org_cd �Ӽ��� tb_org ���̺��� org_cd �Ӽ��� �̿��Ͽ�
-- org_cd, org_name, emp_name �Ӽ��� ��ȸ�϶�
-- ��� ���̺��� �÷��̸��� �μ��ڵ�, �μ���, ������ ������ ����� ��
-- ��, �Ͻ��� ������ ����� ��
select tb_org.org_cd "�μ��ڵ�", org_name "�μ���", emp_name "������"
from cslee.tb_emp, cslee.tb_org
where tb_emp.org_cd = tb_org.org_cd;

-- tb_emp ���̺��� org_cd �Ӽ��� tb_org ���̺��� org_cd �Ӽ��� �̿��Ͽ�
-- org_cd, org_name, emp_name�Ӽ��� ��ȸ�϶�
-- ��� ���̺��� �÷��̸��� �μ��ڵ�, �μ���, ������ ������ ����� ��
-- ��, ����� ������ ����� �� 
select tb_org.org_cd "�μ��ڵ�", org_name "�μ���", emp_name "������"
from cslee.tb_emp join cslee.tb_org
on tb_emp.org_cd = tb_org.org_cd;

-- tb_emp ���̺�� tb_org ���̺��� �̿��Ͽ�
-- �� ���̺��� ��� �Ӽ��� ��ȸ�϶�
-- ��, ũ�ν� ������ ����� �� 
select * from cslee.tb_emp cross join cslee.tb_org;


-- tb_emp ���̺���
-- position �Ӽ��� �̿��Ͽ� "��å", 
-- salary �Ӽ��� �̿��Ͽ� "��å��_�޿�_��"
-- �� ���� �Ӽ����� �̷���� ���̺��� ��ȸ�϶�
-- ��, position �Ӽ� ���� �׷� ����, �� position�� salary�� ���� ����� ��
-- ���� ������ "��å��_�޿�_��"�� ���� ��
select position "��å", sum(salary) "��å��_�޿�_��"
from cslee.tb_emp
group by position
order by "��å��_�޿�_��" desc;

-- tb_emp ���̺���
-- emp_name���� 3���ڷ� �̷���� �̸��� �����Ѵ�.
-- emp_name �Ӽ��� �̿��Ͽ� �̸� ��� ���ڰ� '��'�� ������ ����϶�
-- emp_name �Ӽ��� "������"���� ����� ��
select emp_name "������"
from cslee.tb_emp
where emp_name like '_��%';


-- tb_emp ���̺���
-- position, emp_name, gender �Ӽ��� �̿��Ͽ�
-- "��å", "������", "����" ������ ��ȸ�϶�
-- ��, gender �Ӽ��� ������ ���� case ����Ͽ� (M, F)�� (��, ��)�� �ٲپ� ��ȸ�� �� 
select position "��å", emp_name "������", (case when gender = 'M' then '��' else '��' end) "����"
from cslee.tb_emp;


-- tb_emp ���̺���
-- emp_name �Ӽ��� "������", salary �Ӽ��� "�޿����"���� �ٲپ� ��ȸ�ϵ�
-- salary�� 
-- 200000001 �̻��� 'A'
-- 100000001 ~ 200000000�̸� 'B'
-- 50000001 ~ 100000000 �̸� 'C'
-- �� �ܿ��� 'D'�� �ٲپ� ��ȸ�϶�.
select emp_name, (case
                  when salary > 200000001 then 'A'
                  when salary between 100100001 and 200000000 then 'B'
                  when salary between 50000001 and 100000000 then 'C'
                  else 'D' end)
from cslee.tb_emp;


-- tb_org ���̺���
-- org_cd, type, org_name, up_org_cd �Ӽ��� ��ȸ�ϵ�
-- up_org_cd �Ӽ���
-- null ���� ������ '���� �μ��� ����'���� �ٲپ� ��ȸ�϶�
select org_cd "�����ڵ�", type "�з�", org_name "������", coalesce(up_org_cd, '���� �μ��� ����') "�����μ���"
from cslee.tb_org;


-- tb_org ���̺��� type �Ӽ����� �׷� ����,
-- type �÷��� �� �󵵸� �� �÷����� �̷���� ���̺��� ��ȸ�϶�
-- ��, �󵵰� 3�� ���ų� Ŀ�� �ϰ�, �󵵰� ���� ������ ��ȸ�� ��
select type "�з�", count(type) "����" 
from cslee.tb_org
group by type
having count(type) >= 3
order by count(type);


-- with�� ��� subquery
-- �غ��� ������ ���� �˻��ؼ� ã�Ƽ� �غ���
-- ������ ���翡�� �ش� ���� ����
-- tb_emp ���̺��� salary �Ӽ��� 
-- 200000001 �̻��̸� 'A'
-- 100000001 ~ 200000000 �̸� 'B'
-- 50000001 ~ 100000000 �̸� 'C'
-- �� �ܿ��� 'D'�� �ְ�, �÷��̸��� "�޿����"���� �Ѵ�.
-- ��ȸ�� ���̺��� with���� Ȱ���Ͽ� �ӽ����̺�� �����,
-- �ӽ� ���̺��� "�޿����"�� �׷�����,
-- "�޿����"�� "�޿����"�� �󵵸� ��ȸ�϶�.
-- ������ �޿������ ���� ������ (A ~ D ��)
with ranking as (select (case
             when salary > 200000001 then 'A'
             when salary between 100000001 and 200000000 then 'B'
             when salary between 50000001 and 100000000 then 'C'
             else 'D' end) "�޿����"
     from cslee.tb_emp)
select "�޿����", count("�޿����")
from ranking
group by "�޿����"
order by "�޿����";