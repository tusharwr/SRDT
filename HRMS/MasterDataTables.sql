SELECT * FROM ps_personal_data a LEFT OUTER JOIN  PS_JOB B ON A.EMPLID=B.EMPLID AND a.emplid='1000';
SELECT * FROM ps_personal_data;
select * from PS_PERSONAL_DT_FST;
 select * from ps_compensation;
 SELECT * FROM PS_JOB;
 SELECT * FROM ps_jobcode_tbl;
 select * from ps_dept_tbl; 
select * from ps_personal_data where emplid='00017';
select * from ps_person where emplid='00017';
select * from ps_person_name where emplid='00017';
select * from PS_ACTION_TBL ;
select  * from ps_HIGH_EDUCLVL_VW;
select * from ps_ACTN_REASON_TBL;
select * from ps_religion_tbl;
select * from ps_pers_data_ind;
select * from ps_DIVERS_RELIGION; --religion
DESC ps_personal_data;
select * from ps_education;
select * from ps_accomplishments;
select * from ps_person;
select * from ps_school_educat; --education
select * from ps_educ_area_study;---education
select * from ps_co_degree_vw;
select * from ps_degree_vw;

SELECT * FROM ps_physical_exam where emplid='00017'; ---BLOOD TYPE
SELECT * FROM ps_TBH_JPM_DEG_VW; --DEGREE

select * from ps_SRMC_JOBRVW_TBL;
SELECT * FROM PS_PYE_BANKACCT; --BANK A/C 
SELECT * FROM PS_PERS_NID WHERE EMPLID='00017'; --NATIONAL ID
SELECT * FROM PS_EMAIL_ADDRESSES; --EMAILID
SELECT * FROM PS_GPIN_PF_ENROLL; ---Payee Registration Number

----------------------FOR DEGREE WITH DESCRIPTION-------------------------------------------
SELECT a.emplid, a.cm_jp_per_prfl_id, a.jpm_jp_type,B.jpm_profile_id,B.jpm_cat_item_id,b.jpm_cat_type,b.jpm_item_key_id,b.jpm_jp_qual_set,b.jpm_jp_qual_set2,b.jpm_wf_status
, c.accomplishment, c.descr,c.descrshort, c.accomp_category,c.education_lvl
FROM PS_CM_JPM_EPRFL_VW A 
LEFT OUTER JOIN ps_TBH_JPM_DEG_VW B ON a.cm_jp_per_prfl_id= b.jpm_profile_id
left outer join ps_co_degree_vw c on c.accomplishment=B.JPM_CAT_ITEM_ID;
----------------------FOR DEGREE WITH DESCRIPTION----------------------------------------------

SELECT *  FROM PS_CM_JPM_EPRFL_VW A 
LEFT OUTER JOIN ps_TBH_JPM_DEG_VW B ON a.cm_jp_per_prfl_id= b.jpm_profile_id
left outer join ps_co_degree_vw c on c.accomplishment=B.JPM_CAT_ITEM_ID;

select * from ps_CM_JPM_EPRFL_VW;
SELECT * FROM PS_SCHOOL_EDUCAT;

select * from ps_dept_tbl;
SELECT * FROM ps_jobcode_tbl;
SELECT DISTINCT DEPTID FROM ps_DEPT_TBL;
SELECT DISTINCT JOBCODE 
  FROM PS_DEPT_TBL;

select * from ps_DIVERS_RELIGION;
select * from ps_JPM_CAT_TYP2_VW;
select * from ps_JPM_CAT_TYPES;
select * from ps_major_tbl;
SELECT * FROM ps_employMENT;
select * from ps_person_name;
select A.EMPLID from ps_JOBCODE_TBL B LEFT OUTER JOIN PS_JOB A ON a.jobcode=B.jobcode ;

 select * from ps_compensation;
 SELECT REPLACE('0','NA') FROM DUAL;
 select * from ps_HRS_SAL_GRADE_I;
 


 ---------------------------COMPENSATION----------------------------------------
 SELECT COMPRATE, comp_ratecd FROM PS_COMPENSATION WHERE EMPLID='00017';
-----------------------------------CASE--------------------------------------------------------------

--------------------------
SELECT * FROM ps_personal_data where emplid='00017';
-----------------------------------------MASTERDATA-------------------------------------------------------------------------------------------------------------
 
 SELECT dis rownum,  distinct A.EMPLID 
 , A.ALTER_EMPLID 
 , A.NAME_PREFIX 
 , A.NAME_PREFIX || ' ' ||A.FIRST_NAME || ' ' || A.MIDDLE_NAME || ' ' ||A.LAST_NAME AS display_name 
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
 WHERE a1.emplid=b.SUPERVISOR_ID) AS supervisor_name , B.HR_STATUS , B.EMPL_STATUS , N.ACTION_DESCR , B.ACTION_REASON , O.DESCR AS descr2 , B.SHIFT , B.REG_TEMP , B.FULL_PART_TIME , B.COMPANY , B.EMPL_RCD , B.EFFDT , B.EFFSEQ , B.LOCATION , B.PAYGROUP ,( 
 SELECT NVL(( 
 SELECT (c1.comprate) 
  FROM PS_COMPENSATION c1 
 WHERE c1.EMPLID=c.EMPLID 
   AND c1.comp_ratecd='DA' ),'') 
  FROM DUAL) AS COMPRATE1 ,( 
 SELECT NVL(( 
 SELECT (c1.comprate) 
  FROM PS_COMPENSATION c1 
 WHERE c1.EMPLID=c.EMPLID 
   AND c1.comp_ratecd='BASIC' ),'') 
  FROM DUAL) AS COMPRATE12 ,(( 
 SELECT NVL(( 
 SELECT (c1.comprate) 
  FROM PS_COMPENSATION c1 
 WHERE c1.EMPLID=c.EMPLID 
   AND c1.comp_ratecd='DA' ),'') 
  FROM DUAL) /( 
 SELECT NVL(( 
 SELECT (c1.comprate) 
  FROM PS_COMPENSATION c1 
 WHERE c1.EMPLID=c.EMPLID 
   AND c1.comp_ratecd='BASIC' ),'') 
  FROM DUAL)*100)AS PERCENTAGE ,( 
 SELECT NVL(( 
 SELECT (c1.comprate) 
  FROM PS_COMPENSATION c1 
 WHERE c1.EMPLID=c.EMPLID 
   AND c1.comp_ratecd='HRA' ),'') 
  FROM DUAL) AS COMPRATE_NOFTE ,( 
 SELECT NVL(( 
 SELECT (c1.comprate) 
  FROM PS_COMPENSATION c1 
 WHERE c1.EMPLID=c.EMPLID 
   AND c1.comp_ratecd='TA' ),'') 
  FROM DUAL) AS COMPRATE_USED ,( 
 SELECT NVL(( 
 SELECT (C1.comprate) 
  FROM PS_COMPENSATION C1 
 WHERE C1.EMPLID=C.EMPLID 
   AND C1.comp_ratecd='OTHERS' ),'') 
  FROM DUAL) AS COMPRATE_USED_OT ,( 
 SELECT SUM(C1.COMPRATE) 
  FROM PS_COMPENSATION C1 
 WHERE C1.EMPLID=C.EMPLID 
   AND C1.comp_ratecd IN('DA','BASIC','HRA','TA','OTHERS')) AS COMPRATE , M.ACCOUNT_EC_ID ,s.gpin_reg_nbr , B.EMPL_CLASS , B.GRADE , B.BUSINESS_UNIT , F.DATE_ACQUIRED 
   , F.SCHOOL_TYPE , F.EDUCATION_LVL_ACHV , F.COMPLETED , F.SCHOOL_CODE , F.SCHOOL , F.AVERAGE_GRADE , G.AREA_OF_STUDY , G.AREA_OF_STDY_GRADE , K.ACCOMPLISHMENT
   , K.DESCR AS DESCR3 , K.DESCRSHORT , J.JPM_INTEGER_2 , J.SCHOOL_DESCR , J.MAJOR_DESCR , J.MINOR_DESCR , J.AVERAGE_GRADE AS GRADE_DFLT , J.JPM_YN_1 , J.JPM_DECIMAL_1 , t.descr
  FROM (((((((((((((((((((PS_PERSONAL_DATA A LEFT OUTER JOIN PS_JOB B ON A.EMPLID = B.EMPLID ) LEFT OUTER JOIN PS_JOBCODE_TBL L ON L.JOBCODE = B.JOBCODE ) LEFT OUTER JOIN PS_ACTION_TBL N ON N.ACTION = B.ACTION ) LEFT OUTER JOIN PS_ACTN_REASON_TBL O ON O.ACTION = B.ACTION 
   AND O.ACTION_REASON = B.ACTION_REASON ) LEFT OUTER JOIN PS_PERS_DATA_IND D ON A.EMPLID = D.EMPLID ) LEFT OUTER JOIN PS_DIVERS_RELIGION E ON A.EMPLID = E.EMPLID ) LEFT OUTER JOIN PS_SCHOOL_EDUCAT F ON A.EMPLID = F.EMPLID ) LEFT OUTER JOIN PS_EDUC_AREA_STUDY G ON A.EMPLID = G.EMPLID ) LEFT OUTER JOIN PS_PHYSICAL_EXAM H ON A.EMPLID = H.EMPLID ) LEFT OUTER JOIN PS_CM_JPM_EPRFL_VW I ON A.EMPLID = I.EMPLID ) LEFT OUTER JOIN PS_TBH_JPM_DEG_VW J ON J.JPM_PROFILE_ID = I.CM_JP_PER_PRFL_ID ) LEFT OUTER JOIN PS_CO_DEGREE_VW K ON K.ACCOMPLISHMENT = J.JPM_CAT_ITEM_ID ) LEFT OUTER JOIN PS_HIGH_EDUCLVL_VW P ON P.HIGHEST_EDUC_LVL = A.HIGHEST_EDUC_LVL ) LEFT OUTER JOIN PS_COMPENSATION C ON A.EMPLID = C.EMPLID ) LEFT OUTER JOIN PS_PYE_BANKACCT M ON A.EMPLID=M.EMPLID) LEFT OUTER JOIN PS_PERS_NID Q ON Q.EMPLID=A.EMPLID 
   AND Q.PRIMARY_NID='Y') LEFT OUTER JOIN PS_EMAIL_ADDRESSES R ON R.EMPLID=A.EMPLID 
   AND R.PREF_EMAIL_FLAG='Y') LEFT OUTER JOIN PS_GPIN_PF_ENROLL S ON S.EMPLID=A.EMPLID) left outer join ps_HRS_SAL_GRADE_I t on t.grade=b.grade)
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
   AND C_ED.EFFDT <= SYSDATE));
-----------------------------MASTERDATA--------------------------------------------------------------------

select * from ps_PER_ORG_ASGN where emplid='00017';
select * from ps_srmc_jobrvw_tbl;
SELECT * FROM PS_SRMC_MASTER_VW;