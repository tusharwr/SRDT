SELECT DISTINCT a.ITEM_EFFECTIVE_DT AS DATE2 
 , ( 
 SELECT nvl(SUM(X.item_amt) 
 ,0) 
  FROM PS_item_sf_vw X 
 WHERE X.ITEM_EFFECTIVE_DT=A.ITEM_EFFECTIVE_DT 
   AND X.item_amt>'0') AS DEBIT_SUM, ( 
 SELECT nvl(SUM(Y.total_amount_sf) 
 ,0) 
  FROM PS_CSH_OFF_RECEIPT Y 
 WHERE Y.trans_dt=A.ITEM_EFFECTIVE_DT) AS CREDIT_SUM, ( 
 SELECT (( 
 SELECT nvl(SUM(X.item_amt) 
 ,0) 
  FROM PS_item_sf_vw X 
 WHERE X.ITEM_EFFECTIVE_DT=A.ITEM_EFFECTIVE_DT 
   AND X.item_amt>'0')-( 
 SELECT nvl(SUM(Y.total_amount_sf) 
 ,0) 
  FROM PS_CSH_OFF_RECEIPT Y 
 WHERE Y.trans_dt=A.ITEM_EFFECTIVE_DT)) 
  FROM DUAL) AS OPENING_BALANCE 
  FROM ps_item_sf_vw A, PS_HCR_PER_NAME_I B 
 WHERE A.EMPLID =B.EMPLID 
  GROUP BY A.ITEM_EFFECTIVE_DT;
  
  --------------
  SELECT * FROM PS_SRMU_CSH_SUM_VW;
 
 
 ---------------------------------------
 SELECT * FROM ps_item_sf_vw;
 -------------------------------------
 SELECT DISTINCT a.ITEM_EFFECTIVE_DT AS DATE2 
 , ( 
 SELECT  nvl(SUM(X.item_amt),0) 
  FROM PS_item_sf_vw X 
 WHERE X.last_activity_date=A.last_activity_date 
   AND X.item_amt>'0') AS DEBIT_SUM, ( 
 SELECT nvl(SUM(Y.total_amount_sf),0) 
  FROM PS_CSH_OFF_RECEIPT Y 
 WHERE Y.trans_dt=A.last_activity_date) AS CREDIT_SUM, ( 
 SELECT (( 
 SELECT nvl(SUM(X.item_amt),0) 
  FROM PS_item_sf_vw X 
 WHERE X.last_activity_date=A.last_activity_date 
   AND X.item_amt>'0')-( 
 SELECT nvl(SUM(Y.total_amount_sf),0) 
  FROM PS_CSH_OFF_RECEIPT Y 
 WHERE Y.trans_dt=A.last_activity_date)) 
  FROM DUAL) AS OPENING_BALANCE 
  FROM ps_item_sf_vw A, PS_HCR_PER_NAME_I B 
 WHERE A.EMPLID =B.EMPLID
 and ITEM_EFFECTIVE_DT between '11-SEP-13' and '16-SEP-13';
 