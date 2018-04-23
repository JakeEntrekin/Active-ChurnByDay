create table if not exists factactiveusers
(
	row_number bigint,
	userkey bigint distkey
		constraint factactiveusers___fk
			references dimusers,
	validfromdate timestamp,
	validfromdatekey bigint,
	validtodate timestamp,
	validtodatekey bigint
)
diststyle key
sortkey(validfromdate, validtodate)
;

