SELECT * FROM PS_ITEM_line_VW WHERE EMPLID='00000000001';
SELECT * FROM PS_ITEM_sf_VW WHERE EMPLID='00000000001';

SELECT emplid, account_term, descr, item_amt, applied_amt, item_term FROM PS_ITEM_sf_VW 
WHERE EMPLID='00000000157'; 

select * from ps_srmu_stu_id_vw;
--------------------
  
  select  sysdate+10 from dual;
  
  select * from ps_xl_acad_lvl_vw;
  select * from ps_stdnt_car_term;
  
  select distinct a.emplid,a.acad_year,a.strm,b.descr, b.descrshort from ps_stdnt_car_term a, ps_xl_acad_lvl_vw b
  where a.acad_level_bot= b.fieldvalue;
  
  
  	
SELECT DISTINCT 
A.EMPLID
, A.ADMIT_TERM
, A.ACAD_YEAR
, A.NAME_DISPLAY
, A.NAME_PREFIX_U
, A.FATHER_NAME
, A.CAMPUS_ID
, B.DUE_AMT
, B.ITEM_TERM
, B.SESSION_YEAR
, (CASE WHEN substr( A.ACAD_PROG,0,3)='BTR' THEN ( A.DEGREE || ' (' || substr( A.ACAD_PROG,4 ,2) || ')') ELSE substr( A.ACAD_PROG,0,3) END) as DEGREE
, B.DESCR
, D.FIELDVALUE
, D.DESCR as desc1
, D.DESCRSHORT
  FROM ((PS_SRMU_STU_ID_VW A LEFT OUTER JOIN  PS_SRMU_DUE_AMT B ON  A.EMPLID = B.EMPLID ) LEFT OUTER JOIN  PS_STDNT_CAR_TERM C ON  A.EMPLID = C.EMPLID ), PS_XL_ACAD_LVL_VW D
  WHERE ( B.ITEM_TERM = C.STRM
     AND A.ACAD_PROG = C.ACAD_PROG_PRIMARY
     AND D.EFFDT =
        (SELECT MAX(D_ED.EFFDT) FROM PS_XL_ACAD_LVL_VW D_ED
        WHERE D.FIELDVALUE = D_ED.FIELDVALUE
          AND D_ED.EFFDT <= SYSDATE)
     AND C.ACAD_LEVEL_BOT = D.FIELDVALUE ) order by a.emplid;
 