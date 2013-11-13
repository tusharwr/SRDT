SELECT DISTINCT A.EMPLID, A.CAMPUS_ID, A.ACAD_PROG, A.ADMIT_TERM, A.ACAD_PLAN, A.ACAD_YEAR, A.DESCR, A.ACAD_PLAN_TYPE
, A.DEGREE, A.NAME_DISPLAY
, A.ADDRESS_TYPE
, A.COUNTRY
,(case when a.address_type like('PERM') THEN  a.address1 ||' ' || a.address2 ||' ' || a.address3 ||' ' ||  a.city ||' ' || A.postal  END) AS PERMANENTADDR
,(case when a.address_type like('HOME') THEN a.address1 ||' ' || a.address2 ||' ' || a.address3 ||' ' ||  a.city ||' ' || A.postal  END) AS HOMEADDR
, A.ADDRESS1
, A.ADDRESS2
, A.ADDRESS3
, A.ADDRESS4
, A.PHONE_TYPE
, A.CITY
,(case when a.phone_type like ('CELL') THEN A.PHONE END) AS CELLPHONE 
,(case when a.phone_type like ('HOME') THEN A.phone END) AS HOMEPHONE
, A.PHONE
, A.BLOOD_TYPE
, A.POSTAL
, A.PEOPLE_RELATION
, A.FATHER_NAME
, A.DESCR1
, A.YEARS_OF_EDUCATN, A.L_BARCODE, A.NAME_PREFIX, A.NAME_PREFIX_U
, (CASE WHEN substr(  A.ACAD_PROG,0,3)='BTR'  THEN (  A.DEGREE || ' (' || substr(  A.ACAD_PROG,4 ,2) || ')')
   WHEN substr(  A.ACAD_PROG,0,3)='MTR' THEN 'M.TECH'
   ELSE substr(  A.ACAD_PROG,0,3)
   END)
  FROM (PS_SRMU_STU_ID_VW A LEFT OUTER JOIN  PS_SRM_TUT_INC2_VW B ON  A.EMPLID = B.EMPLID )
  WHERE ( A.EMPLID = '00000000157'
  AND a.address_type='HOME' AND A.PHONE_TYPE='HOME' )
  ORDER BY 1;
  
  SELECT * FROM PS_SRMU_STU_ID_VW;
  
  SELECT EMPLID FROM ps_addresses WHERE address_type='PERM';
  SELECT EMPLID, address_type FROM ps_addresses WHERE emplid='00000000157';
  select * from ps_phone_type_xlvw ;