SELECT A.EMPLID, A.ACAD_PROG, A.ADMIT_TERM, B.ACAD_PLAN, C.ACAD_YEAR, D.DESCR, D.ACAD_PLAN_TYPE, D.DEGREE
  FROM PS_ACAD_PROG A, PS_ACAD_PLAN B, PS_TERM_TBL C, PS_ACAD_PLAN_TBL D
  WHERE ( A.EFFDT =
        (SELECT MAX(A_ED.EFFDT) FROM PS_ACAD_PROG A_ED
        WHERE A.EMPLID = A_ED.EMPLID
          AND A.ACAD_CAREER = A_ED.ACAD_CAREER
          AND A.STDNT_CAR_NBR = A_ED.STDNT_CAR_NBR
          AND A_ED.EFFDT <= SYSDATE)
    AND A.EFFSEQ =
        (SELECT MAX(A_ES.EFFSEQ) FROM PS_ACAD_PROG A_ES
        WHERE A.EMPLID = A_ES.EMPLID
          AND A.ACAD_CAREER = A_ES.ACAD_CAREER
          AND A.STDNT_CAR_NBR = A_ES.STDNT_CAR_NBR
          AND A.EFFDT = A_ES.EFFDT)
     AND A.EMPLID = B.EMPLID
     AND A.ACAD_CAREER = B.ACAD_CAREER
     AND A.STDNT_CAR_NBR = B.STDNT_CAR_NBR
     AND A.EFFSEQ = B.EFFSEQ
     AND B.EFFDT =
        (SELECT MAX(B_ED.EFFDT) FROM PS_ACAD_PLAN B_ED
        WHERE B.EMPLID = B_ED.EMPLID
          AND B.ACAD_CAREER = B_ED.ACAD_CAREER
          AND B.STDNT_CAR_NBR = B_ED.STDNT_CAR_NBR
          AND B_ED.EFFDT <= SYSDATE)
    AND B.EFFSEQ =
        (SELECT MAX(B_ES.EFFSEQ) FROM PS_ACAD_PLAN B_ES
        WHERE B.EMPLID = B_ES.EMPLID
          AND B.ACAD_CAREER = B_ES.ACAD_CAREER
          AND B.STDNT_CAR_NBR = B_ES.STDNT_CAR_NBR
          AND B.EFFDT = B_ES.EFFDT)
     AND A.ACAD_CAREER = C.ACAD_CAREER
     AND C.INSTITUTION = A.INSTITUTION
     AND A.ADMIT_TERM = C.STRM
     AND B.ACAD_PLAN = D.ACAD_PLAN
     AND D.EFFDT =
        (SELECT MAX(D_ED.EFFDT) FROM PS_ACAD_PLAN_TBL D_ED
        WHERE D.INSTITUTION = D_ED.INSTITUTION
          AND D.ACAD_PLAN = D_ED.ACAD_PLAN
          AND D_ED.EFFDT <= SYSDATE) )
  ORDER BY 1;
  
  -----------------------------------
  select * from ps_SRMU_ST_PLAN_VW;
  ------------------------------------------
  SELECT A.EMPLID, A.NAME, A.NAME_DISPLAY, B.COUNTRY, B.ADDRESS1, B.ADDRESS2, B.ADDRESS3, B.ADDRESS4, B.CITY,B.POSTAL, C.PHONE, D.BLOOD_TYPE
  FROM (((PS_PERSONAL_DATA A LEFT OUTER JOIN  PS_ADDRESSES B ON  A.EMPLID = B.EMPLID ) LEFT OUTER JOIN  PS_PERSONAL_PHONE C ON  A.EMPLID = C.EMPLID ) LEFT OUTER JOIN  PS_PHYSICAL_EXAM D ON  A.EMPLID = D.EMPLID )
  WHERE ( B.EFFDT =
        (SELECT MAX(B_ED.EFFDT) FROM PS_ADDRESSES B_ED
        WHERE B.EMPLID = B_ED.EMPLID
          AND B.ADDRESS_TYPE = B_ED.ADDRESS_TYPE
          AND B_ED.EFFDT <= SYSDATE) );
    ------------------------------------------      
        select * FROM PS_SRMU_ST_DATA_VW;
        
        ------------------------------
        select * from ps_relationships;
        SELECT * FROM PS_ACAD_PROG;
        ---------------------------------------
        SELECT * FROM ps_srmu_stu_id_vw;
        -------------------------------
        
        SELECT A.EMPLID 
 , A.ACAD_PROG 
 , A.ADMIT_TERM 
 , A.ACAD_PLAN 
 , A.ACAD_YEAR 
 , A.DESCR 
 , A.ACAD_PLAN_TYPE 
 , A.DEGREE 
 ,b.name_prefix 
 , B.NAME_DISPLAY 
 , B.COUNTRY 
 ,B.ADDRESS_TYPE
 , B.ADDRESS1 
 , B.ADDRESS2 
 , B.ADDRESS3 
 , B.ADDRESS4 
 , B.CITY 
 , b.phone_type
 , B.PHONE 
 , B.BLOOD_TYPE 
 , B.POSTAL 
 , C.PEOPLE_RELATION 
 , c.name_prefix AS NAME_PREFIX_U 
 , C.NAME AS FATHER_NAME 
 , D.DESCR AS DESCR1 
 , D.YEARS_OF_EDUCATN 
 , B.CAMPUS_ID 
  FROM (((PS_SRMU_ST_PLAN_VW A LEFT OUTER JOIN PS_SRMU_ST_DATA_VW B ON A.EMPLID = B.EMPLID ) LEFT OUTER JOIN PS_RELATIONSHIPS C ON A.EMPLID = C.EMPLID ) LEFT OUTER JOIN PS_DEGREE_TBL D ON D.DEGREE = A.DEGREE ) 
 WHERE ( D.EFFDT = ( 
 SELECT MAX(D_ED.EFFDT) 
  FROM PS_DEGREE_TBL D_ED 
 WHERE D.DEGREE = D_ED.DEGREE 
   AND D_ED.EFFDT <= SYSDATE
   and a.emplid='00000000689') );
   
   
   select * from ps_srmu_stu_inf_vw;
   
   
  