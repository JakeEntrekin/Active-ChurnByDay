truncate table datetable;

INSERT INTO jentrekin.DateTable (calendar_date, calendar_date_29_days_prior, datekey, current_day_of_year_flag)
	select dateadd(day,  t4.c*10000 + t3.c*1000 + t2.c*100 + t1.c*10 + t0.c , '2014-12-31' ) as calendar_date,
		DATEADD(DAY, -29, dateadd(day,  t4.c*10000 + t3.c*1000 + t2.c*100 + t1.c*10 + t0.c , '2014-12-31' )),
     cast(replace(cast(dateadd(day,  t4.c*10000 + t3.c*1000 + t2.c*100 + t1.c*10 + t0.c ,'2014-12-31' ) as varchar(10)), '-', '') as int)as DateKey,
    case when cast(getdate() as date) = dateadd(day,  t4.c*10000 + t3.c*1000 + t2.c*100 + t1.c*10 + t0.c , '2014-12-31' ) then 1 else 0 end

	from
	(select 0 c union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t0,
	(select 0 c union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t1,
	(select 0 c union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t2,
	(select 0 c union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) t3,
	(select 0 c union all select 1 union all select 2) t4


;
