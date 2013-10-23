SELECT DISTINCT A.EMPLID, A.CAMPUS_ID,
    B.NAME_DISPLAY "NAME",
    C.ACAD_PROG "COURSE",
    SUBSTR(C.ACAD_PROG,4,2) "BRANCH",
    E.NAME "FATHER/MOTHER" ,
   
    (  SELECT SUM(H.LINE_AMT) FROM PS_ITEM_LINE_VW H WHERE H.EMPLID=A.EMPLID AND  H.LINE_AMT>'0' AND H.LINE_ACTION != 'REF') AS "TOTAL FEE PAYABLE"   ,
 
        ( SELECT SUM(G.ITEM_AMT) FROM PS_ITEM_SF_VW G WHERE G.EMPLID=A.EMPLID  AND G.ITEM_AMT>'0' AND G.ACCOUNT_NBR='TUITION001') AS "COURSE FEE APPLIED",
 
         ( SELECT SUM(G.applied_amt) FROM PS_ITEM_SF_VW G WHERE G.EMPLID=A.EMPLID   AND G.ACCOUNT_NBR='TUITION001') AS "COURSE FEES PAID",
         
--  (  ( SELECT SUM(H.LINE_AMT) FROM PS_ITEM_LINE_VW H,PS_stdnt_srch A WHERE H.EMPLID=A.EMPLID AND H.ACCOUNT_NBR  IN('HOSTEL001')  AND H.LINE_ACTION != 'REF' AND H.LINE_AMT>0 
--    group by h.emplid )
--    UNION 
--    ( select 0 FROM PS_ITEM_LINE_VW H,PS_stdnt_srch A WHERE H.EMPLID=A.EMPLID AND H.EMPLID 
--    NOT IN (SELECT DISTINCT h.emplid FROM PS_ITEM_LINE_VW H,PS_stdnt_srch A WHERE H.EMPLID=A.EMPLID AND H.ACCOUNT_NBR  IN('HOSTEL001')  AND H.LINE_ACTION != 'REF' AND H.LINE_AMT>0 
--    group by h.emplid ) 
--    group by h.emplid  ) )
        --  NVL((SELECT G.ITEM_AMT  FROM PS_ITEM_SF_VW G WHERE G.EMPLID=A.EMPLID  AND G.ITEM_AMT>'0' AND G.ACCOUNT_NBR='BUS001'),0) AS "BUS FEE PAID"
           
         (SELECT (SELECT SUM(G.applied_amt) FROM PS_ITEM_SF_VW G WHERE G.EMPLID=A.EMPLID   AND G.ACCOUNT_NBR='TUITION001') 
       +
       NVL((SELECT SUM(H.LINE_AMT) FROM PS_ITEM_LINE_VW H WHERE H.EMPLID=A.EMPLID AND H.ACCOUNT_NBR='HOSTEL001'  AND H.LINE_ACTION != 'REF' AND H.LINE_AMT>0),0)
       +
      NVL((SELECT G.ITEM_AMT  FROM PS_ITEM_SF_VW G WHERE G.EMPLID=A.EMPLID  AND G.ITEM_AMT>'0' AND G.ACCOUNT_NBR='BUS001'),0)
      FROM DUAL) AS "TOTAL FEE PAID",
                ( SELECT  (SELECT SUM(H.LINE_AMT) FROM PS_ITEM_LINE_VW H WHERE H.EMPLID=A.EMPLID AND H.LINE_AMT>'0' AND H.LINE_ACTION != 'REF') 
       -
       (
     (SELECT SUM(G.applied_amt) FROM PS_ITEM_SF_VW G WHERE G.EMPLID=A.EMPLID   AND G.ACCOUNT_NBR='TUITION001') 
      +
     NVL((SELECT SUM(H.LINE_AMT) FROM PS_ITEM_LINE_VW H WHERE H.EMPLID=A.EMPLID AND H.ACCOUNT_NBR='HOSTEL001' AND H.LINE_ACTION != 'REF' AND H.LINE_AMT>0),0)
     +
   NVL((SELECT G.ITEM_AMT  FROM PS_ITEM_SF_VW G WHERE G.EMPLID=A.EMPLID  AND G.ITEM_AMT>0 AND G.ACCOUNT_NBR='BUS001'),0)
   )  FROM DUAL)AS "TOTAL BALANCE"
--       
--      (SELECT 
--      CASE WHEN  (SELECT SUM(G.ITEM_AMT) "TOTAL FEE PAYABLE" FROM PS_ITEM_SF_VW G WHERE EMPLID=A.EMPLID  AND G.ITEM_AMT>0)
--       -
 --       (SELECT SUM(J.ACCOUNT_BALANCE) FROM PS_ACCOUNT_VW J WHERE J.EMPLID=A.EMPLID )<='0'
  --        THEN 'FULL'ELSE 'NOT FULL' END AS PAYMENT FROM DUAL) AS PAYMENT,
           
   --  F.ABSENCE_DATE "DUE DATE"
               
  FROM PS_stdnt_srch A,
    PS_HCR_PERSON_NM_I B,
    PS_ACAD_PROG C,
    PS_RELATIONSHIPS E,
--   PS_SRMU_SNTFER_TBL F,
   PS_ITEM_SF_VW G,
    PS_ITEM_LINE_VW H
--    PS_CSH_OFF_RCPT_VW I,
--    PS_ACCOUNT_VW J
    
    
  WHERE A.EMPLID=B.EMPLID
  AND A.EMPLID  =C.EMPLID
  AND A.EMPLID  =E.EMPLID
 -- AND A.EMPLID  =F.EMPLID
 AND A.EMPLID  =G.EMPLID 
 AND A.EMPLID  =H.EMPLID   order by a.emplid;
 -- AND A.EMPLID  =I.EMPLID
--  AND A.EMPLID  =J.EMPLID;



