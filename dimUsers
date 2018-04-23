create table if not exists dimusers
(
	userkey bigint default "identity"(135260, 0, '1,1'::text) not null
		constraint dimusers_pkey
			primary key,
	user_id bigint not null,
	userdescriptrion varchar(255),
	insertdate date,
	updatedate date
)
sortkey(userkey, user_id)
;
