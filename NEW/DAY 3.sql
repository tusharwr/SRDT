SELECT *
FROM
  (SELECT DISTINCT A.CAMPUS_ID,
    B.NAME_DISPLAY,
    C.ACAD_PROG "COURSE",
    SUBSTR(D.ACAD_PROG,4,2) "BRANCH",
    E.NAME "FATHER/MOTHER" ,
   
    (  SELECT SUM(LINE_AMT) FROM PS_ITEM_LINE_VW WHERE EMPLID=A.EMPLID AND ACCOUNT_TERM LIKE '%' AND LINE_AMT>'0' AND LINE_ACTION != 'REF') AS "TOTAL FEE PAYABLE",         
        ( SELECT SUM(G.ITEM_AMT) FROM PS_ITEM_SF_VW G WHERE G.EMPLID=A.EMPLID AND G.ACCOUNT_TERM LIKE '%' AND G.ITEM_AMT>0 AND G.ACCOUNT_NBR='TUITION001') AS "COURSE FEE APPLIED",
          ( SELECT SUM(applied_amt) FROM PS_ITEM_SF_VW WHERE EMPLID=A.EMPLID AND ACCOUNT_TERM LIKE '%'  AND ACCOUNT_NBR='TUITION001') AS "COURSE FEES PAID",
          (SELECT SUM(LINE_AMT) FROM PS_ITEM_LINE_VW WHERE EMPLID=A.EMPLID AND ACCOUNT_NBR='HOSTEL001' AND ACCOUNT_TERM LIKE '%' AND LINE_ACTION != 'REF' AND LINE_AMT>0) AS "HOSTEL FEE PAID",
           
           NVL((SELECT ITEM_AMT  FROM PS_ITEM_SF_VW WHERE EMPLID=A.EMPLID AND ACCOUNT_TERM LIKE '%' AND ITEM_AMT>0 AND ACCOUNT_NBR='BUS001'),0) AS "BUS FEE PAID",
           
           (SELECT (SELECT SUM(applied_amt) FROM PS_ITEM_SF_VW WHERE EMPLID=A.EMPLID AND ACCOUNT_TERM LIKE '%'  AND ACCOUNT_NBR='TUITION001') 
        +
        NVL((SELECT SUM(LINE_AMT) FROM PS_ITEM_LINE_VW WHERE EMPLID= AND ACCOUNT_NBR='HOSTEL001' AND ACCOUNT_TERM LIKE '%' AND LINE_ACTION != 'REF' AND LINE_AMT>0),0)
        +
       NVL((SELECT ITEM_AMT  FROM PS_ITEM_SF_VW WHERE EMPLID=A.EMPLID AND ACCOUNT_TERM LIKE '%' AND ITEM_AMT>0 AND ACCOUNT_NBR='BUS001'),0)
         FROM DUAL) AS "TOTAL FEE PAID",
           
           ( SELECT  (SELECT SUM(LINE_AMT) FROM PS_ITEM_LINE_VW WHERE EMPLID=A.EMPLID AND ACCOUNT_TERM LIKE '%' AND LINE_AMT>'0' AND LINE_ACTION != 'REF') 
        -
        (
        (SELECT SUM(applied_amt) FROM PS_ITEM_SF_VW WHERE EMPLID=A.EMPLID AND ACCOUNT_TERM LIKE '%'  AND ACCOUNT_NBR='TUITION001') 
        +
        NVL((SELECT SUM(LINE_AMT) FROM PS_ITEM_LINE_VW WHERE EMPLID=A.EMPLID AND ACCOUNT_NBR='HOSTEL001' AND ACCOUNT_TERM LIKE '%' AND LINE_ACTION != 'REF' AND LINE_AMT>0),0)
        +
       NVL((SELECT ITEM_AMT  FROM PS_ITEM_SF_VW WHERE EMPLID=A.EMPLID AND ACCOUNT_TERM LIKE '%' AND ITEM_AMT>0 AND ACCOUNT_NBR='BUS001'),0)
       )  FROM DUAL)AS "TOTAL BALANCE",
       
           
            (SELECT 
      CASE WHEN  (SELECT SUM(G.ITEM_AMT) "TOTAL FEE PAYABLE" FROM PS_ITEM_SF_VW G WHERE EMPLID='00000000001' AND G.ACCOUNT_TERM LIKE '%' AND G.ITEM_AMT>0)
       -
        (SELECT SUM(J.ACCOUNT_BALANCE) FROM PS_ACCOUNT_VW J WHERE J.EMPLID=A.EMPLID AND J.ACCOUNT_TERM LIKE '%')<=0
          THEN 'FULL'ELSE 'NOT FULL' END AS PAYMENT FROM DUAL) AS PAYMENT,
           
          F.ABSENCE_DATE "DUE DATE"
               
  FROM PS_stdnt_srch A,
    PS_HCR_PERSON_NM_I B,
    PS_ACAD_PROG C,
    PS_ACAD_PROG D,
    PS_RELATIONSHIPS E,
    PS_SRMU_SNTFER_TBL F,
    PS_ITEM_SF_VW G,
   -- PS_ITEM_SF_VW H,
    PS_CSH_OFF_RCPT_VW I
    --PS_ACCOUNT_VW J
    
    
  WHERE A.EMPLID=B.EMPLID
  AND A.EMPLID  =C.EMPLID
  AND A.EMPLID  =D.EMPLID
  AND A.EMPLID  =E.EMPLID
  AND A.EMPLID  =F.EMPLID
  AND A.EMPLID  =G.EMPLID
--  AND A.EMPLID  =H.EMPLID
  AND A.EMPLID  =I.EMPLID
  --AND A.EMPLID=''
  )
WHERE ROWNUM<=800
ORDER BY ROWNUM;







--BALANCE
        SELECT  (SELECT SUM(LINE_AMT) FROM PS_ITEM_LINE_VW WHERE EMPLID='00000000001' AND ACCOUNT_TERM LIKE '13%' AND LINE_AMT>'0' AND LINE_ACTION != 'REF') 
        -
        (
        (SELECT SUM(applied_amt) FROM PS_ITEM_SF_VW WHERE EMPLID='00000000001' AND ACCOUNT_TERM LIKE '13%'  AND ACCOUNT_NBR='TUITION001') 
        +
        NVL((SELECT SUM(LINE_AMT) FROM PS_ITEM_LINE_VW WHERE EMPLID='00000000001' AND ACCOUNT_NBR='HOSTEL001' AND ACCOUNT_TERM LIKE '13%' AND LINE_ACTION != 'REF' AND LINE_AMT>0),0)
        +
       NVL((SELECT ITEM_AMT  FROM PS_ITEM_SF_VW WHERE EMPLID='00000000001' AND ACCOUNT_TERM LIKE '13%' AND ITEM_AMT>0 AND ACCOUNT_NBR='BUS001'),0)
       ) AS BALANCE FROM DUAL;
       


--SELECT *  FROM PS_ITEM_SF_VW;
--SELECT *  FROM PS_CSH_OFF_RCPT_VW;
--SELECT SUM(A.ITEM_AMT) FROM PS_ITEM_SF_VW A,PS_CSH_OFF_RCPT_VW B WHERE A.EMPLID='00000000157'AND a.item_amt>'0' GROUP BY A.EMPLID;
--SELECT SUM(B.total_amount_sf) FROM PS_ITEM_SF_VW A,PS_CSH_OFF_RCPT_VW B WHERE A.EMPLID='00000000157'AND a.item_amt>'0' GROUP BY A.EMPLID;

  
  SELECT CASE WHEN (
        (SELECT SUM(H.ITEM_AMT)
        FROM PS_ITEM_SF_VW H,
          PS_CSH_OFF_RCPT_VW I
        WHERE H.EMPLID='00000000157'
        AND H.item_amt>'0'
        GROUP BY H.EMPLID
        ) -
        (SELECT SUM(I.total_amount_sf)
        FROM PS_ITEM_SF_VW H,
          PS_CSH_OFF_RCPT_VW I
        WHERE H.EMPLID='00000000157'
        AND H.item_amt>'0'
        GROUP BY H.EMPLID
        )<='0')  THEN 'FULL' END AS PAYMENT FROM DUAL;
  
 SELECT TOTAL_AMOUNT FROM PS_ANTC_AID_TOT;
 
  --WHERE ((A.ITEM_AMT-B.TOTAL_AMOUNT_SF)<=0)
  --SELECT * FROM PS_ACAD_PLAN;
  --SELECT * FROM PS_SCC_PERS_PHN_H ;
  --SELECT * FROM PS_RELATIONSHIPS;
  SELECT CASE WHEN (SELECT SUM(H.ITEM_AMT)
        FROM PS_ITEM_SF_VW H,
          PS_CSH_OFF_RCPT_VW I
        WHERE H.EMPLID='00000000001'
        AND H.item_amt>'0'
        GROUP BY H.EMPLID)
         -
        (SELECT SUM(I.total_amount_sf)
        FROM PS_ITEM_SF_VW H,
          PS_CSH_OFF_RCPT_VW I
        WHERE H.EMPLID='00000000001'
        AND H.item_amt>'0'
        GROUP BY H.EMPLID)<=0 THEN '0' ELSE 'ABCD' END AS BALANCE FROM DUAL;
        
        --BALANCE
       SELECT SUM(ACCOUNT_BALANCE) FROM PS_ACCOUNT_VW WHERE EMPLID=00000000001 AND ACCOUNT_TERM LIKE '13%';
         SELECT * FROM PS_ACCOUNT_VW WHERE EMPLID=00000000174 AND ACCOUNT_TERM LIKE '12%';
        
          --cOURSE FEE   
   -- SELECT SUM(ITEM_AMT) FROM PS_ITEM_SF_VW WHERE EMPLID=00000000001 AND ACCOUNT_TERM LIKE '13%' AND ITEM_AMT>0 AND ACCOUNT_NBR='TUITION001';
    
    
    --TOTAL FEES(HOSTEL+TUTION)
     SELECT SUM(LINE_AMT) FROM PS_ITEM_LINE_VW WHERE EMPLID=0000000001 AND ACCOUNT_TERM LIKE '13%' AND LINE_AMT>'0' AND LINE_ACTION != 'REF';
     SELECT * FROM PS_ITEM_LINE_VW WHERE EMPLID=0000000001 AND ACCOUNT_TERM LIKE '13%' AND LINE_AMT>'0';
    SELECT LINE_AMT, descr FROM PS_ITEM_LINE_VW WHERE EMPLID=0000000001 AND ACCOUNT_TERM LIKE '13%';
    
   -- SELECT EMPLID,SUM(ITEM_AMT) "TOTAL FEE PAYABLE" FROM PS_ITEM_SF_VW WHERE EMPLID=00000000001 AND ACCOUNT_TERM LIKE '13%' AND ITEM_AMT>0 GROUP BY EMPLID;   
  SELECT ITEM_AMT  FROM PS_ITEM_SF_VW WHERE EMPLID=00000000001 AND ACCOUNT_TERM LIKE '13%' AND ITEM_AMT>0 AND ACCOUNT_NBR='BUS001' ;
  
              --COURSE FEES PAID  
          SELECT SUM(applied_amt) FROM PS_ITEM_SF_VW WHERE EMPLID=00000000001 AND ACCOUNT_TERM LIKE '13%'  AND ACCOUNT_NBR='TUITION001';
         SELECT * FROM PS_ITEM_SF_VW WHERE EMPLID=00000000001 AND ACCOUNT_TERM LIKE '13%';
        
        
        