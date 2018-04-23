--ACTIVE
select count(distinct f.userkey) as ActiveUsers, dT.DateKey from factActiveUsers f
 JOIN dateTable dT
 on dT.calendar_date between f.validfromdate and f.validtodate
group by dt.DateKey
order by dt.datekey;
