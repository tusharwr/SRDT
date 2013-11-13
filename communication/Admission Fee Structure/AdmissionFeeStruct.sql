SELECT A.EMPLID, A.ADMIT_TERM, A.ACAD_YEAR, A.NAME_DISPLAY, A.COUNTRY, A.ADDRESS1, A.ADDRESS2, A.ADDRESS3, A.ADDRESS4, A.CITY, A.POSTAL, A.PEOPLE_RELATION, A.FATHER_NAME, A.CAMPUS_ID
  FROM PS_SRMU_STU_ID_VW A;
  ---------------------------------------------------------------
  
   SELECT distinct * FROM PS_TERM_SUBFEE_TBL;
  SELECT * FROM PS_TERM_FE_CD_TBL;
  select * from PS_STDNT_TEST_COMP;
  
  SELECT FEE_CODE, sub_fee_code, acad_PROG, flat_amt FROM PS_TERM_SUBFEE_TBL ;
  
  select substr('abcdef',-2,2) from dual;

  ---------------------------
  select * from PS_SRMU_STU_ID_VW where emplid='00000000249';
  select * from PS_SRMU_STU_ID_VW;
  select * from ps_acad_prog;
  select * from PS_TERM_SUBFEE_TBL where emplid='00000000157';
  -----------------------------------
  --------------------------------------------------------------------------------------------
   	
 	 
 SELECT DISTINCT C.EMPLID 
 , A.FEE_CODE 
 , A.STRM 
 , ( CASE WHEN substr( C.ACAD_YEAR 
 ,3 
 ,2)=substr( A.STRM 
 ,1 
 ,2) THEN nvl( A.FLAT_AMT 
 ,0) END) AS AMT1 
 , ( CASE WHEN substr( C.ACAD_YEAR+1 
 ,3 
 ,2)=substr( A.STRM 
 ,1 
 ,2) THEN A.FLAT_AMT END) AS AMT2 
 , ( CASE WHEN substr( C.ACAD_YEAR+2 
 ,3 
 ,2)=substr( A.STRM 
 ,1 
 ,2) THEN A.FLAT_AMT END) AS AMT3 
 , ( CASE WHEN substr( C.ACAD_YEAR+3 
 ,3 
 ,2)=substr( A.STRM 
 ,1 
 ,2) THEN A.FLAT_AMT END) AS AMT4 
 , ( CASE WHEN substr( C.ACAD_YEAR+4 
 ,3 
 ,2)=substr( A.STRM 
 ,1 
 ,2) THEN A.FLAT_AMT END) AS AMT5 
 , (CASE WHEN B.DESCR LIKE ('%Exam%') THEN 'Examination Fees' WHEN B.DESCR LIKE ('%Development%') THEN 'Development Fees' WHEN B.DESCR LIKE ('%Tuition%') THEN 'Tuition Fees' END) AS DESCR 
 , C.ADMIT_TERM 
 , C.ACAD_YEAR 
 , C.NAME_DISPLAY 
 , C.PEOPLE_RELATION 
 , C.FATHER_NAME 
 , C.CAMPUS_ID 
 , C.ADDRESS_TYPE 
 , C.ADDRESS1 
 , C.ADDRESS2 
 , C.ADDRESS3 
 , C.ADDRESS4 
 , C.CITY 
 , C.POSTAL 
 , (CASE WHEN substr( C.ACAD_PROG 
 ,0 
 ,3)='BTR' 
    OR substr( C.ACAD_PROG 
    ,0 
    ,3)='MTR' THEN ( C.DEGREE || ' (' || substr( C.ACAD_PROG 
    ,4 
    ,2) || ')') WHEN substr( C.ACAD_PROG 
    ,0 
    ,3)='MTR' THEN 'M.TECH' ELSE substr( C.ACAD_PROG 
    ,0 
    ,3) END) AS DEGREE25 
    , D.TEST_ID 
    , nvl( D.SCORE_LETTER 
    ,'N/A') AS RANK 
    ,(case when substr(C.acad_year,3,2)=substr(A.strm,1,2) then '1st Year'
  when substr(C.acad_year+1,3,2)=substr(A.strm,1,2) then '2nd Year'
  when substr(C.acad_year+2,3,2)=substr(A.strm,1,2) then '3rd Year'
  when substr(C.acad_year+3,3,2)=substr(A.strm,1,2) then '4th Year'
  when substr(C.acad_year+4,3,2)=substr(A.strm,1,2) then '5th Year'
 END) as Year
  FROM PS_TERM_SUBFEE_TBL A 
  , PS_TERM_FE_CD_TBL B 
  , (PS_SRMU_STU_ID_VW C LEFT OUTER JOIN PS_STDNT_TEST_COMP D ON C.EMPLID = D.EMPLID ) 
 WHERE ( B.FEE_CODE = A.FEE_CODE 
   AND B.SETID = A.SETID 
   AND ( A.STRM NOT LIKE '%02' 
   AND A.FEE_CODE = B.FEE_CODE 
   AND A.SETID = A.SETID 
   AND A.ACAD_PROG = C.ACAD_PROG 
   AND substr( A.FEE_CODE,-2,2) = substr( C.ADMIT_TERM,1,2) 
   AND C.ADDRESS_TYPE = 'PERM' 
   AND C.EMPLID='00000000157') ) 
  ORDER BY 1, 3, 8;