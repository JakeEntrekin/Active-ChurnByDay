truncate table factinactiveusers
INSERT INTO factinactiveusers (row_number, userkey, validfromdate, validfromdatekey, validtodate, validtodatekey)
select row_number, userkey, lastlogin, lastlogindatekey, validloginto, validlogintodatekey from factuseractivitydetail
where churnflag = 1