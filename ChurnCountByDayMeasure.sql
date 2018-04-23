--CHURN
select count(distinct f.UserKey) as Churn, dT.DateKey from factinactiveusers f
JOIN dimusers dUsers
  on f.userkey = dUSers.userkey
JOIN datetable dT
  on dT.calendar_date between f.validfromdate and f.validtodate
 -- and dT.current_day_of_year_flag = 1
  --and dUsers.user_id =104289
group by dt.DateKey
order by dt.datekey;