select distinct a.emplid,
a.name_display,
r.name "Guardian Name",
adr.address1 || ',' || adr.address2 || ',' || adr.address3 || ',' || adr.address4 || ',' || adr.city || ',' || adr.postal as "Address",
phn.phone as "Phone",
a.campus_id,
dt.degree,
substr(apr.acad_prog,4,2) as "Course"

from PS_PERSONAL_DATA A ,
ps_acad_plan ap,
ps_acad_plan_tbl apt,
ps_degree_tbl dt,
ps_acad_prog apr, 
ps_relationships r,
ps_addresses adr,
ps_personal_phone phn

where  
dt.degree=apt.degree and
apt.acad_plan= ap.acad_plan and
ap.emplid=a.emplid and
apr.emplid=a.emplid and
apr.acad_prog= apt.acad_prog and
r.emplid=a.emplid and
adr.emplid=a.emplid  and 
phn.emplid=a.emplid and
phn.pref_phone_flag='Y';
----------------------------------------------
select * from ps_stdnt_car_plnvw;
SELECT * FROM ps_acad_plan_tbl ;
SELECT * FROM ps_acad_plan ;
SELECT * FROM ps_addressesn ;
SELECT * FROM PS_ACAD_PROG ;
select * from PS_DEGREE_TBL ;
SELECT * FROM PS_PERSONAL_PHONE;
SELECT * FROM PS_RELATIONSHIPS r;
SELECT * FROM PS_STUDENT_SRCH;
--------------------------------------
select phn.phone
from PS_PERSONAL_DATA A ,
ps_acad_plan ap,
ps_acad_plan_tbl apt,
ps_degree_tbl dt,
ps_acad_prog apr,
ps_relationships r,
ps_personal_phone phn


where  
dt.degree=apt.degree and
apt.acad_plan= ap.acad_plan and
ap.emplid=a.emplid and
apr.emplid=a.emplid and
apr.acad_prog= apt.acad_prog and
r.emplid=a.emplid and
phn.emplid=a.emplid; 

; 