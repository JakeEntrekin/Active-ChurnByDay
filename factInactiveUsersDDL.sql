create table if not exists factinactiveusers
(
	row_number bigint,
	userkey bigint
		constraint factinactiveusers___fk
			references dimusers,
	validfromdate timestamp,
	validfromdatekey bigint,
	validtodate timestamp,
	validtodatekey bigint
)
sortkey(userkey, validfromdate, validtodate)
;

