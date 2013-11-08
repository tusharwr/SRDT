select * from ps_srmu_stu_id_vw;
select * from ps_item_sf_vw where emplid='00000000157';
select * from ps_item_line_vw where emplid='00000000157';
SELECT * FROM ps_SRMU_TUT_INCMVW;

----------------------------------------------------------
SELECT DISTINCT A.EMPLID, A.NAME_PREFIX, A.NAME_DISPLAY, A.ADDRESS1, A.ADDRESS2, A.ADDRESS3, A.ADDRESS4, A.CITY, A.POSTAL, A.FATHER_NAME, A.CAMPUS_ID, (CASE WHEN substr( A.ACAD_PROG,0,3)='BTR' THEN ( A.DEGREE || ' (' || substr( A.ACAD_PROG,4 ,2) || ')') ELSE substr( A.ACAD_PROG,0,3) END), B.SESSION_YEAR, B.ITEM_AMT, B.DESCR100
  FROM (PS_SRMU_STU_ID_VW A LEFT OUTER JOIN  PS_SRMU_TUT_INCMVW B ON  A.EMPLID = B.EMPLID )
  WHERE ( A.EMPLID = :1 )
  ORDER BY 1;
  ------------------------------------------------------
  
  
  select emplid, name, name_prefix from ps_relationships;
  
  select * from ps_SRMU_STU_ID_VW;

