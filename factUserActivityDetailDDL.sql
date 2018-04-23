create table if not exists factuseractivitydetail
(
	row_number bigint,
	userkey bigint
		constraint factuseractivitydetail___fk
			references dimusers,
	firstlogin timestamp,
	firstlogindatekey bigint,
	lastlogin timestamp,
	lastlogindatekey bigint,
	nextlogin timestamp,
	nextlogindatekey bigint,
	gapsbetweenactivity integer,
	inactivedate timestamp,
	inactivedatekey bigint,
	daysconsecutivelyloggedin integer,
	tasksusedpergroup bigint,
	validloginto timestamp,
	churnflag integer,
	validlogintodatekey integer
)
sortkey(userkey, inactivedate)
;

