SELECT DISTINCT A.EMPLID, A.ALTER_EMPLID, A.NAME_PREFIX, A.DISPLAY_NAME, A.SEX, A.GPIN_CASTE, A.NATIONAL_ID_TYPE, A.NATIONAL_ID, A.REG_REGION, A.RELIGION_CD, A.BLOOD_TYPE, A.MAR_STATUS, TO_CHAR(A.MAR_STATUS_DT,'YYYY-MM-DD'), TO_CHAR(A.BIRTHDATE,'YYYY-MM-DD'), A.BIRTHPLACE, A.BIRTHSTATE, A.BIRTHCOUNTRY, A.ADDRESS100, A.EMAIL_ADDR, A.PHONE, A.HIGHEST_EDUC_LVL, A.DESCR, A.DEPTID, A.DESCR1, A.SUPERVISOR_ID, A.SUPERVISOR_NAME, A.HR_STATUS, A.EMPL_STATUS, A.ACTION_DESCR, A.ACTION_REASON, A.DESCR2, A.SHIFT, A.REG_TEMP, A.FULL_PART_TIME, A.COMPANY, A.EMPL_RCD, TO_CHAR(A.EFFDT,'YYYY-MM-DD'), A.EFFSEQ, A.LOCATION, A.PAYGROUP, A.COMPRATE1, A.COMPRATE2, A.PERCENTAGE, A.COMPRATE_NOFTE, A.COMPRATE_USED, A.COMPRATE_USED_OT, A.COMPRATE, A.ACCOUNT_EC_ID, A.GPIN_REG_NBR, A.EMPL_CLASS, A.GRADE, TO_CHAR(A.DATE_ACQUIRED,'YYYY-MM-DD'), A.SCHOOL_TYPE, A.EDUCATION_LVL_ACHV, A.COMPLETED, A.SCHOOL_CODE, A.SCHOOL, A.AVERAGE_GRADE, A.AREA_OF_STUDY, A.AREA_OF_STDY_GRADE, A.ACCOMPLISHMENT, A.DESCR3, A.DESCRSHORT, A.JPM_INTEGER_2, A.SCHOOL_DESCR, A.MAJOR_DESCR, A.MINOR_DESCR, A.GRADE_DFLT, A.JPM_YN_1, A.JPM_DECIMAL_1
  FROM PS_SRMC_MASTER_VW ;
  
  SELECT * FROM PS_SRMC_MASTER_VW;
  SELECT DISTINCT A.EMPLID 
 , A.ALTER_EMPLID 
 , A.NAME_PREFIX 
 , A.FIRST_NAME || ' ' || A.MIDDLE_NAME || ' ' ||A.LAST_NAME AS display_name 
 , A.SEX 
 , D.GPIN_CASTE 
 ,Q.NATIONAL_ID_TYPE 
 ,Q.NATIONAL_ID 
 , E.REG_REGION 
 , E.RELIGION_CD 
 , H.BLOOD_TYPE 
 , A.MAR_STATUS 
 , A.MAR_STATUS_DT 
 , A.BIRTHDATE 
 , a.address1 || ' ' || a.address2 || ' '|| a.address3 || ' ' || a.city || ' ' ||a.state || ' '|| a.postal AS Address100 
 ,R.EMAIL_ADDR 
 ,a.phone 
 , A.BIRTHPLACE 
 , A.BIRTHCOUNTRY 
 , A.BIRTHSTATE 
 , A.HIGHEST_EDUC_LVL 
 , P.DESCR 
 , B.DEPTID 
 , B.JOBCODE 
 , L.DESCR AS descr1 
 , B.SUPERVISOR_ID 
 , ( 
 SELECT A1.FIRST_NAME || A1.MIDDLE_NAME || A1.LAST_NAME 
  FROM ps_personal_data a1 
 WHERE a1.emplid=b.SUPERVISOR_ID) AS supervisor_name , B.HR_STATUS , B.EMPL_STATUS , N.ACTION_DESCR , B.ACTION_REASON , O.DESCR AS descr2 , B.SHIFT , B.REG_TEMP , B.FULL_PART_TIME , B.COMPANY , B.EMPL_RCD , B.EFFDT , B.EFFSEQ , B.LOCATION , B.PAYGROUP 
 ,(  SELECT NVL((  SELECT (c1.comprate)   FROM PS_COMPENSATION c1  WHERE c1.EMPLID=c.EMPLID    AND c1.comp_ratecd='DA' ),'')   FROM DUAL) AS COMPRATE1 
 ,(  SELECT NVL((  SELECT (c1.comprate)   FROM PS_COMPENSATION c1  WHERE c1.EMPLID=c.EMPLID    AND c1.comp_ratecd='BASIC' ),'')   FROM DUAL) AS COMPRATE12
 ,((  SELECT NVL((  SELECT (c1.comprate)   FROM PS_COMPENSATION c1  WHERE c1.EMPLID=c.EMPLID    AND c1.comp_ratecd='DA' ),'')   FROM DUAL) /(  SELECT NVL((  SELECT (c1.comprate)   FROM PS_COMPENSATION c1  WHERE c1.EMPLID=c.EMPLID    AND c1.comp_ratecd='BASIC' ),'')   FROM DUAL)*100)AS PERCENTAGE 
 ,(  SELECT NVL((  SELECT (c1.comprate)   FROM PS_COMPENSATION c1  WHERE c1.EMPLID=c.EMPLID    AND c1.comp_ratecd='HRA' ),'')   FROM DUAL) AS COMPRATE_NOFTE 
 ,(  SELECT NVL((  SELECT (c1.comprate)   FROM PS_COMPENSATION c1  WHERE c1.EMPLID=c.EMPLID    AND c1.comp_ratecd='TA' ),'')   FROM DUAL) AS COMPRATE_USED 
 ,(  SELECT NVL((  SELECT (C1.comprate)   FROM PS_COMPENSATION C1  WHERE C1.EMPLID=C.EMPLID    AND C1.comp_ratecd='OTHERS' ),'')   FROM DUAL) AS COMPRATE_USED_OT 
 ,(  SELECT SUM(C1.COMPRATE)   FROM PS_COMPENSATION C1 WHERE C1.EMPLID=C.EMPLID    AND C1.comp_ratecd IN('DA','BASIC','HRA','TA','OTHERS')) AS COMPRATE

 , M.ACCOUNT_EC_ID ,s.gpin_reg_nbr , B.EMPL_CLASS , B.GRADE , B.BUSINESS_UNIT , F.DATE_ACQUIRED , F.SCHOOL_TYPE , F.EDUCATION_LVL_ACHV , F.COMPLETED 
 , F.SCHOOL_CODE , F.SCHOOL , F.AVERAGE_GRADE , G.AREA_OF_STUDY , G.AREA_OF_STDY_GRADE , K.ACCOMPLISHMENT , K.DESCR AS DESCR3 , K.DESCRSHORT
 , J.JPM_INTEGER_2 , J.SCHOOL_DESCR , J.MAJOR_DESCR , J.MINOR_DESCR , J.AVERAGE_GRADE AS GRADE_DFLT , J.JPM_YN_1 , J.JPM_DECIMAL_1 
 
  FROM ((((((((((((((((((PS_PERSONAL_DATA A LEFT OUTER JOIN PS_JOB B ON A.EMPLID = B.EMPLID ) LEFT OUTER JOIN PS_JOBCODE_TBL L ON L.JOBCODE = B.JOBCODE )
  LEFT OUTER JOIN PS_ACTION_TBL N ON N.ACTION = B.ACTION ) LEFT OUTER JOIN PS_ACTN_REASON_TBL O ON O.ACTION = B.ACTION 
   AND O.ACTION_REASON = B.ACTION_REASON ) LEFT OUTER JOIN PS_PERS_DATA_IND D ON A.EMPLID = D.EMPLID ) LEFT OUTER JOIN PS_DIVERS_RELIGION E ON A.EMPLID = E.EMPLID ) 
   LEFT OUTER JOIN PS_SCHOOL_EDUCAT F ON A.EMPLID = F.EMPLID ) LEFT OUTER JOIN PS_EDUC_AREA_STUDY G ON A.EMPLID = G.EMPLID )
   LEFT OUTER JOIN PS_PHYSICAL_EXAM H ON A.EMPLID = H.EMPLID ) LEFT OUTER JOIN PS_CM_JPM_EPRFL_VW I ON A.EMPLID = I.EMPLID )
   LEFT OUTER JOIN PS_TBH_JPM_DEG_VW J ON J.JPM_PROFILE_ID = I.CM_JP_PER_PRFL_ID ) LEFT OUTER JOIN PS_CO_DEGREE_VW K ON K.ACCOMPLISHMENT = J.JPM_CAT_ITEM_ID ) 
   LEFT OUTER JOIN PS_HIGH_EDUCLVL_VW P ON P.HIGHEST_EDUC_LVL = A.HIGHEST_EDUC_LVL ) LEFT OUTER JOIN PS_COMPENSATION C ON A.EMPLID = C.EMPLID )
   LEFT OUTER JOIN PS_PYE_BANKACCT M ON A.EMPLID=M.EMPLID) LEFT OUTER JOIN PS_PERS_NID Q ON Q.EMPLID=A.EMPLID 
   AND Q.PRIMARY_NID='Y') LEFT OUTER JOIN PS_EMAIL_ADDRESSES R ON R.EMPLID=A.EMPLID 
   AND R.PREF_EMAIL_FLAG='Y') LEFT OUTER JOIN PS_GPIN_PF_ENROLL S ON S.EMPLID=A.EMPLID) 
 WHERE ( P.EFFDT = ( 
 SELECT MAX(P_ED.EFFDT) 
  FROM PS_HIGH_EDUCLVL_VW P_ED 
 WHERE P.MARKET = P_ED.MARKET 
   AND P.HIGHEST_EDUC_LVL = P_ED.HIGHEST_EDUC_LVL 
   AND P_ED.EFFDT <= SYSDATE) 
   AND C.EFFDT = ( 
 SELECT MAX(C_ED.EFFDT) 
  FROM PS_COMPENSATION C_ED 
 WHERE C.EMPLID = C_ED.EMPLID 
   AND C.EMPL_RCD = C_ED.EMPL_RCD 
   AND C_ED.EFFDT <= SYSDATE)) ;
   
   
   select * from ps_employment;
   SELECT * FROM PS_TBH_JPM_DEG_VW;