Steps to deploy and execute
The data model was created using DataGrip.  Additionally, you'll need to change your sql dialect to SQL Server.  Refer to SQLDialect.jpg
for steps.

Order of Deployment.  In all of the below scripts, you’ll want to connect to the jentrekin schema, right click the schema name, and select New – Console.  Then you’d want to paste the scripts into the new console window and hit either Cntrl+Enter OR the Play button.
Refer to Console.JPG and Execution.JPG

1.	Execute DateTableDDL.sql
2.	Execute DateTableFill.sql
3.	Execute dimAccountDDL.sql
4.	Execute dimUsersDDL.sql
5.	Execute dimAccountFill.sql
6.	Execute dimUsersFill.sql
7.	Execute viewDimAccountDDL.sql
8.	Execute viewDimUsersDDL.sql
9.	Execute TasksUsedDetailDDL.sql
10.	Execute TasksUsedFill.sql
11.	NOTE this script enables an incremental load, so the first time there’s no need for any modifications.
12.	Full load executes in approximately 2 minutes or less.
13.	However, if you in the future need to do a full reload, you would need to uncomment out the truncate statement and then comment out the highlighted lines of the code shown here:
--TRUNCATE TABLE jentrekin.TasksUsedDetail
INSERT INTO jentrekin.TasksUsedDetail ( zap_id, user_id, userkey, account_id, accountkey, date, datekey, min_timestamp, tasks_used, errors)
SELECT t.zap_id, t."user_id ", coalesce(d.userkey, -1) as UserKey,
  t.account_id, coalesce(dAC.accountkey, -1) as AccountKey, t.date,
  cast(replace(cast(t.date as varchar(10)), '-', '') as int) as DateKey, t.min_timestamp, t.tasks_used, t.errors
from source_data.tasks_used t LEFT JOIN jentrekin.dimusers d on t."user_id " = d.user_id
left join jentrekin.dimaccount dAC
  on t.account_id = dAC.account_id
WHERE t.date > (SELECT isnull(MAX(date), '1900-01-01') from jentrekin.tasksuseddetail) --set up incremental load
	          
14.	Execute factUserActivityDDL.sql
15.	Execute factUserActivityDetail.sql
16.	Execute factActiveUsersDDL.sql
17.	Execute factInactiveUsersDDL.sql
18.	Execute factActiveUsersFill.sql
19.	Execute factInactiveUsersDDL.sql
20.	Once the above deployment is complete, you should then be able to run the Churn and Active queries in steps 5 and 6 below.
21.	Execute ChurnCountMeasureByDay.sql to get a count of distinct users who contributed to churn each day.
22.	Execute ActiveCountMeasureByDay.sql to get a count of distinct users who are considered active each day.
