SELECT A.EMPLID, A.ADMIT_TERM, A.ACAD_YEAR, A.NAME_DISPLAY, A.COUNTRY, A.ADDRESS1, A.ADDRESS2, A.ADDRESS3, A.ADDRESS4, A.CITY, A.POSTAL, A.PEOPLE_RELATION, A.FATHER_NAME, A.CAMPUS_ID
  FROM PS_SRMU_STU_ID_VW A;
  ---------------------------------------------------------------
  
   SELECT * FROM PS_TERM_SUBFEE_TBL;
  SELECT * FROM PS_TERM_FE_CD_TBL;
  select * from ps_acad_prog;
  select * from PS_STDNT_TEST_COMP;
  
  SELECT FEE_CODE, sub_fee_code, acad_PROG, flat_amt FROM PS_TERM_SUBFEE_TBL ;
  
  select substr('abcdef',-2,2) from dual;

  ---------------------------
  select * from PS_SRMU_STU_ID_VW;
  -----------------------------------
  SELECT DISTINCT C.EMPLID, A.FEE_CODE, A.STRM, A.FLAT_AMT, B.DESCR, C.ADMIT_TERM, C.ACAD_YEAR, C.NAME_DISPLAY, C.PEOPLE_RELATION, C.FATHER_NAME, C.CAMPUS_ID, C.ADDRESS1
  , C.ADDRESS2, C.ADDRESS3, C.ADDRESS4, C.CITY, C.POSTAL
  , (CASE WHEN substr( C.ACAD_PROG,0,3)='BTR' THEN ( C.DEGREE || ' (' || substr( C.ACAD_PROG,4 ,2) || ')') ELSE substr( C.ACAD_PROG,0,3) END) as "Degree"
  FROM PS_TERM_SUBFEE_TBL A, PS_TERM_FE_CD_TBL B, PS_SRMU_STU_ID_VW C
  WHERE ( B.FEE_CODE = A.FEE_CODE
    AND B.SETID = A.SETID
    AND ( A.STRM NOT LIKE '%02'
     AND A.FEE_CODE = B.FEE_CODE
     AND A.SETID = A.SETID
     AND A.ACAD_PROG = C.ACAD_PROG
     AND C.EMPLID = '00000001157'
     AND substr( A.FEE_CODE,-2,2) = substr( C.ADMIT_TERM,1,2) ) )
  ORDER BY 1, 3;
  -------------------------------------------------------------------------
   
   SELECT DISTINCT C.EMPLID, A.FEE_CODE, 
   A.STRM
   , A.FLAT_AMT,
   (case when b.descr like ('%Exam%') then 'Examination Fees'
   when  b.descr like ('%Development%') then 'Development Fees'
   when  b.descr like ('%Tuition%') then 'Tuition Fees'
   end) as Description
   ,C.ADMIT_TERM, C.ACAD_YEAR, C.NAME_DISPLAY, C.PEOPLE_RELATION, C.FATHER_NAME, C.CAMPUS_ID, C.ADDRESS1
  , C.ADDRESS2, C.ADDRESS3, C.ADDRESS4, C.CITY, C.POSTAL
  , (CASE WHEN substr( C.ACAD_PROG,0,3)='BTR' THEN ( C.DEGREE || ' (' || substr( C.ACAD_PROG,4 ,2) || ')') ELSE substr( C.ACAD_PROG,0,3) END) as "Degree"
  FROM PS_TERM_SUBFEE_TBL A, PS_TERM_FE_CD_TBL B, PS_SRMU_STU_ID_VW C
  WHERE ( B.FEE_CODE = A.FEE_CODE
    AND B.SETID = A.SETID
    AND ( A.STRM NOT LIKE '%02'
     AND A.FEE_CODE = B.FEE_CODE
     AND A.SETID = A.SETID
     AND A.ACAD_PROG = C.ACAD_PROG
     AND C.EMPLID = '00000001157'
     AND substr( A.FEE_CODE,-2,2) = substr( C.ADMIT_TERM,1,2) ) )
  ORDER BY 1, 3;