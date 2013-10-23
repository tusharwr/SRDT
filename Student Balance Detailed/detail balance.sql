select DISTINCT  a.emplid , 

a.name_display,
C.ACAD_PROG,
G.ITEM_TERM,

(select distinct d.descr1 from ps_class_roster_vw D   where d.emplid=a.emplid and c.acad_prog=d.acad_prog_primary) AS "DESCRIPTION",

 ( select case 
WHEN G.ACCOUNT_NBR ='HOSTEL001'  THEN 'Y'
ELSE 'N'
END
FROM PS_ITEM_SF_VW G WHERE G.EMPLID=A.EMPLID AND  g.item_term=H.ITEM_TERM AND ACCOUNT_NBR IN ('HOSTEL001') ) AS "HOSTEL",

  ( select case 
WHEN G.ACCOUNT_NBR ='BUS001'  THEN 'Y'
ELSE 'N'
END
FROM PS_ITEM_SF_VW G WHERE G.EMPLID=A.EMPLID AND  g.item_term=H.ITEM_TERM AND ACCOUNT_NBR IN ('BUS001') ) AS "BUS",

(SELECT SUM(H.LINE_AMT) FROM PS_ITEM_LINE_VW H WHERE H.EMPLID=A.EMPLID AND H.LINE_AMT>'0' AND H.LINE_ACTION != 'REF' AND H.ITEM_TERM=G.ITEM_TERM) AS "TOTAL CHARGE",

(select SUM(g.applied_amt) from PS_ITEM_SF_VW g where g.emplid=a.emplid and account_nbr in('TUITION001') and H.ITEM_TERM=G.ITEM_TERM GROUP BY emplid) as "COURSE FEES PAID", 

(Select NVL(SUM(G.applied_amt),0) from PS_ITEM_SF_VW G where g.emplid=a.emplid and account_nbr in('HOSTEL001') and H.ITEM_TERM=G.ITEM_TERM GROUP BY emplid)AS "HOSTEL FEES PAID",

(Select NVL(SUM(G.applied_amt),0) from PS_ITEM_SF_VW G where g.emplid=a.emplid and account_nbr in('BUS001') and H.ITEM_TERM=G.ITEM_TERM GROUP BY emplid)AS "BUS FEES PAID",

((SELECT SUM(H.LINE_AMT) FROM PS_ITEM_LINE_VW H WHERE H.EMPLID=A.EMPLID AND  H.LINE_AMT>'0' AND H.LINE_ACTION != 'REF' AND H.ITEM_TERM=G.ITEM_TERM GROUP BY emplid)
   -
   (SELECT SUM(G.APPLIED_AMT) FROM  PS_ITEM_SF_VW G WHERE a.emplid= g.emplid and H.ITEM_TERM=G.ITEM_TERM GROUP BY emplid))AS "BALANCE "
   
 
from PS_stdnt_srch A ,
PS_ACAD_PROG C,
PS_ITEM_LINE_VW H,
PS_ITEM_SF_VW G

where
G.ITEM_TERM='1301' AND
C.ACAD_PROG='MBA01' and
C.EMPLID=A.EMPLID AND
H.sel_group !=' ' and
h.item_term=g.item_term and 
a.emplid=g.emplid and
A.EMPLID=H.emplid;

SELECT * FROM ps_srmu_stblsum_vw WHERE ITEM_TERM='1301' AND
ACAD_PROG='MBA01';