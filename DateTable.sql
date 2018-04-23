create table if not exists datetable
(
	calendar_date date not null
		constraint datetable_pkey
			primary key,
	calendar_date_29_days_prior date not null,
	datekey integer not null,
	current_day_of_year_flag integer
)
sortkey(calendar_date, datekey)
;
