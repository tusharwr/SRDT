-----------------------------------------------------MAIN STARTS---------------------------------------------------------------------
select DISTINCT  a.emplid,
a.name_display,
a.campus_id,

-----DEGREE----------
B.DEGREE,

------BRANCH-------
(SELECT   CASE 
WHEN b.acad_prog LIKE ('%BTR%') THEN substr(b.acad_prog, 4, 2)
END
FROM ps_acad_plan_tbl b where a.emplid=c.emplid and b.acad_plan=C.ACAD_PLAN
) as "Branch",
--------VALID TILL--------------------
(select case
when  c.ACAD_Plan LIKE('%BTR%') then '2012-16'
END
FROM PS_PERSONAL_DATA A, ps_acad_plan_TBL B, ps_acad_plan C, PS_DEGREE_TBL D WHERE  b.acad_plan=C.ACAD_PLAN AND B.degree=D.degree )
from PS_PERSONAL_DATA A ,
ps_acad_plan_tbl B,
ps_acad_plan C,
PS_ACAD_PROG ap,
PS_DEGREE_TBL D,
PS_RELATIONSHIPS r,
ps_addresses ad


where A.EMPLID='00000000157' AND
B.ACAD_PLAN=C.ACAD_PLAN AND 
B.DEGREE=D.DEGREE AND
C.EMPLID=A.EMPLID;

--------------------------------------MAIN ENDS--------------------------------------------------------------------------




select a.campus_id from PS_PERSONAL_DATA A, ps_acad_plan_TBL B, ps_acad_plan C, PS_DEGREE_TBL D where  A.EMPLID=C.EMPLID AND b.acad_plan=C.ACAD_PLAN AND B.degree=D.degree;

select r.name from PS_PERSONAL_DATA A, ps_acad_plan_TBL B, ps_acad_plan C, PS_DEGREE_TBL D,PS_RELATIONSHIPS r where  A.EMPLID=C.EMPLID  and r.emplid=a.emplid;

SELECT * FROM ps_acad_plan_tbl ;
SELECT * FROM ps_acad_plan ;
SELECT * FROM ps_addresses ;
SELECT * FROM PS_ACAD_PROG ;
select * from PS_DEGREE_TBL ;
SELECT * FROM PS_PERSONAL_PHONE;
SELECT * FROM PS_RELATIONSHIPS r;

SELECT DESCR FROM PS_A

SELECT * FROM PS_STUDENT_SRCH;

select * from ps_acad_plan;


--------------------------FOR BRANCH--------------------------------------
SELECT CASE 
WHEN b.acad_prog LIKE ('%BTR%') THEN substr(b.acad_prog, 4, 2)
END
FROM PS_PERSONAL_DATA A,ps_acad_plan_tbl b,ps_acad_plan C,PS_DEGREE_TBL d where a.emplid=c.emplid and b.acad_plan=C.ACAD_PLAN AND B.degree=D.degree ;

------------------------FOR DEGREE-----------------------
select  b.DEGREE from PS_PERSONAL_DATA A, ps_acad_plan_TBL B, ps_acad_plan C, PS_DEGREE_TBL D where  A.EMPLID=C.EMPLID AND b.acad_plan=C.ACAD_PLAN AND B.degree=D.degree;

-----------------FOR VALID TILL--------------------
(select   case
when  c.ACAD_Plan LIKE('%BTR%') then '2012-16'
END
FROM PS_PERSONAL_DATA A, ps_acad_plan_TBL B, ps_acad_plan C, PS_DEGREE_TBL D WHERE  b.acad_plan=C.ACAD_PLAN AND B.degree=D.degree );


SELECT * FROM PS_ACAD_PLAN WHERE effdt LIKE ('%12') AND ACAD_PLAN LIKE('%BTR%');
-------------------------------------------
(SELECT P.PHONE FROM PS_PERSONAL_PHONE P WHERE P.EMPLID=A.EMPLID AND P.PREF_PHONE_FLAG='Y' ) AS "PHONE"


SELECT distinct degree FROM ps_acad_plan_tbl B;
SELECT * FROM PS_RELATIONSHIPS where EMPLID='00000000213' ;
SELECT DISTINCT A.EMPLID FROM PS_RELATIONSHIPS D,PS_PERSONAL_DATA A,PS_ACAD_PROG C WHERE  A.EMPLID=C.EMPLID AND C.EMPLID=D.EMPLID ;


--------------------BKUP-------------------------------------------------------------------------------------
-----------------------------------------------------MAIN STARTS---------------------------------------------------------------------
select distinct a.emplid,
a.name_display,
a.campus_id,
(SELECT DISTINCT B.DEGREE FROM ps_acad_plan_tbl B WHERE C.ACAD_PROG=B.ACAD_PROG ),

(SELECT DISTINCT CASE 
WHEN C.acad_prog LIKE ('BTR%') THEN substr(C.acad_prog, 4, 2)
END
FROM PS_ACAD_PROG C WHERE C.ACAD_PROG=B.ACAD_PROG and a.emplid=c.emplid
) as "Branch",

(select DISTINCT  case
when c.admit_term like('1201') AND C.ACAD_PROG LIKE('BTR%') then '2012-16'
when c.admit_term like('1201') AND C.ACAD_PROG LIKE('BBA%') OR C.ACAD_PROG LIKE('BCA%') then '2012-15'
when c.admit_term like('1201') AND C.ACAD_PROG LIKE('MBA') OR   C.ACAD_PROG LIKE('PGDM%') OR  C.ACAD_PROG LIKE('MCA%') then '2012-14'
when c.admit_term like('1301') AND C.ACAD_PROG LIKE('BTR%') then '2013-17'
when c.admit_term like('1301') AND C.ACAD_PROG LIKE('BBA%') OR C.ACAD_PROG LIKE('BCA%') then '2013-16'
when c.admit_term like('1301') AND C.ACAD_PROG LIKE('MBA') OR   C.ACAD_PROG LIKE('PGDM%') OR  C.ACAD_PROG LIKE('MCA%') then '2013-15'
when c.admit_term like('1401') AND C.ACAD_PROG LIKE('BTR%') then '2014-18'
when c.admit_term like('1401') AND C.ACAD_PROG LIKE('BBA%') OR C.ACAD_PROG LIKE('BCA%') then '2014-17'
when c.admit_term like('1401') AND C.ACAD_PROG LIKE('MBA') OR   C.ACAD_PROG LIKE('PGDM%') OR  C.ACAD_PROG LIKE('MCA%') then '2014-16'
END
FROM PS_ACAD_PROG C WHERE  C.ACAD_PROG=B.ACAD_PROG and a.emplid=c.emplid) AS "VALID DATE",

D.NAME as "FATHER NAME",

e.address1 || ', '  || e.address2 || ', ' || e.address3|| ', ' || e.address4|| ', ' || e.city || ', '|| e.postal AS "ADDRESS"




from PS_PERSONAL_DATA A ,
ps_acad_plan_tbl B,
PS_ACAD_PROG C,
PS_RELATIONSHIPS D,
ps_addresses e,
PS_PERSONAL_PHONE P


where 
C.ACAD_PROG=B.ACAD_PROG AND
C.EMPLID=A.EMPLID AND
D.EMPLID=A.EMPLID and
e.emplid=a.emplid ;
--------------------------------------BKP ENDS--------------------------------------------------------------------------