create table if not exists tasksuseddetail
(
	dw_id bigint default "identity"(127606, 0, '1,1'::text) not null
		constraint tasksuseddetail_pkey
			primary key,
	zap_id bigint,
	user_id bigint not null,
	userkey bigint not null,
	account_id bigint,
	accountkey bigint not null,
	date date,
	datekey bigint,
	min_timestamp timestamp,
	tasks_used bigint,
	errors bigint,
	dw_timestamp timestamp default getdate()
)
;
