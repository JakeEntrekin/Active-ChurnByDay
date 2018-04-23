truncate table factactiveusers;
INSERT INTO factactiveusers (row_number, userkey, validfromdate, validfromdatekey, validtodate, validtodatekey)
select row_number, userkey, firstlogin, firstlogindatekey, validloginto, validlogintodatekey
from factuseractivitydetail
where churnflag <> 1
order by firstlogindatekey;