INSERT INTO jentrekin.dimUsers (user_id, userdescriptrion, insertdate, updatedate)
SELECT DISTINCT T."user_id ", CAST(T."user_id " AS VARCHAR(255)), GETDATE(), GETDATE()
from source_data.tasks_used t LEFT JOIN jentrekin.dimUsers d on t."user_id " = d.user_id
where D.UserKey IS NULL

UPDATE jentrekin.dimUsers
SET UserDescriptrion = t."user_id "
FROM jentrekin.dimUsers t1  JOIN source_data.tasks_used t
on t1.user_id = t."user_id "
and t1.UserDescriptrion <> t."user_id ";