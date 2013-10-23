SELECT DISTINCT A.EMPLID,
    B.NAME_DISPLAY "NAME",
    
    C.ACAD_PROG,G.ITEM_TERM, 
    
    (select distinct d.descr1 from ps_class_roster_vw D   where d.emplid=a.emplid and c.acad_prog=d.acad_prog_primary) AS "DESCRIPTION",
    
   (SELECT SUM(H.LINE_AMT) FROM PS_ITEM_LINE_VW H WHERE H.EMPLID=A.EMPLID AND H.LINE_AMT>'0' AND H.LINE_ACTION != 'REF' AND H.ITEM_TERM=G.ITEM_TERM) AS "TOTAL CHARGE", 
   
   (SELECT NVL(SUM(G.APPLIED_AMT),0) FROM  PS_ITEM_SF_VW G WHERE a.emplid= g.emplid AND H.item_term=g.item_term ) AS "TOTAL PAID",    
   ((SELECT SUM(H.LINE_AMT) FROM PS_ITEM_LINE_VW H WHERE H.EMPLID=A.EMPLID AND  H.LINE_AMT>'0' AND H.LINE_ACTION != 'REF')
   -
   (SELECT SUM(G.APPLIED_AMT) FROM  PS_ITEM_SF_VW G WHERE a.emplid= g.emplid))AS "CURRENT BALANCE "
    
    FROM PS_stdnt_srch A,
    PS_HCR_PERSON_NM_I B,
    PS_ACAD_PROG C,
    PS_ITEM_LINE_VW H, 
    PS_ITEM_SF_VW G
    
    WHERE  A.EMPLID=B.EMPLID AND
    A.EMPLID=C.EMPLID AND 
    A.EMPLID=H.emplid AND 
    H.sel_group !=' ' AND
    A.EMPLID=G.EMPLID AND
    G.ITEM_TERM='1301' AND
    C.ACAD_PROG='MBA01' AND
    h.item_term=g.item_term and
    ((SELECT SUM(H.LINE_AMT) FROM PS_ITEM_LINE_VW H WHERE H.EMPLID=A.EMPLID AND  H.LINE_AMT>'0' AND H.LINE_ACTION != 'REF')
   -
   (SELECT SUM(g.APPLIED_AMT) FROM  PS_ITEM_SF_VW G WHERE a.emplid= g.emplid))>0 AND
   G.LAST_ACTIVITY_DATE< CURRENT_DATE;
    
    select * from ps_SRMU_BALANCE_VW where acad_prog='MBA01' and item_term='1301';
   