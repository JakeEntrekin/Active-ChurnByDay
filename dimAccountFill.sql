INSERT INTO jentrekin.dimAccount (account_id, accountdescriptrion, insertdate, updatedate)
SELECT DISTINCT T."account_id", CAST(T."account_id" AS VARCHAR(255)), GETDATE(), GETDATE()
from TasksUsedDetail t LEFT JOIN jentrekin.dimAccount d on t.account_id = d.account_id
where D.AccountKey IS NULL;

UPDATE jentrekin.dimAccount
SET AccountDescriptrion = t."account_id",
  UpdateDate = getdate()
FROM jentrekin.dimAccount t1  JOIN TasksUsedDetail t
on t1.account_id = t."account_id"
and t1.AccountDescriptrion <> t."account_id";
