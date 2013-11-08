SELECT * FROM ps_STDNT_TEST_COMP;
select emplid, line_amt, descr from PS_ITEM_LINE_VW where emplid='00000000157';
-------------------------------------------------------

SELECT emplid, item_amt,descr FROM PS_ITEM_SF_VW where emplid='00000000157';

select distinct b.emplid,
(select a.item_amt from PS_ITEM_SF_VW a where a.descr like ('%Exam%') and a.emplid=b.emplid and a.item_amt>0) as EXAM_FEES
,(select a.item_amt from PS_ITEM_SF_VW a where a.descr like ('%Tuition%') and a.emplid=b.emplid and a.item_amt>0) as TUITION_FEES
,(select a.item_amt from PS_ITEM_SF_VW a where a.descr like ('%Development%') and a.emplid=b.emplid and a.item_amt>0) as Development_fees
,(select abs(a.item_amt) from PS_ITEM_SF_VW a where a.descr like ('%Caution Money TUT%') and a.emplid=b.emplid ) as TUITI
from PS_ITEM_SF_VW b
where b.emplid='00000000157' ;
----------------------------------------------------

SELECT A.EMPLID, A.ADMIT_TERM, A.ACAD_YEAR, A.NAME_DISPLAY, A.COUNTRY, A.ADDRESS1, A.ADDRESS2, A.ADDRESS3, A.ADDRESS4, A.CITY, A.POSTAL, A.PEOPLE_RELATION, A.FATHER_NAME, A.CAMPUS_ID
  FROM PS_SRMU_STU_ID_VW A;