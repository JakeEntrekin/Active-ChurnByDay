TRUNCATE TABLE jentrekin.TasksUsedDetail
INSERT INTO jentrekin.TasksUsedDetail ( zap_id, user_id, userkey, account_id, accountkey, date, datekey, min_timestamp, tasks_used, errors)
SELECT t.zap_id, t."user_id ", coalesce(d.userkey, -1) as UserKey,
  t.account_id, coalesce(dAC.accountkey, -1) as AccountKey, t.date,
  cast(replace(cast(t.date as varchar(10)), '-', '') as int) as DateKey, t.min_timestamp, t.tasks_used, t.errors
from source_data.tasks_used t LEFT JOIN jentrekin.dimusers d on t."user_id " = d.user_id
left join jentrekin.dimaccount dAC
  on t.account_id = dAC.account_id
WHERE t.date > (SELECT isnull(MAX(date), '1900-01-01') from jentrekin.tasksuseddetail) --set up incremental load
