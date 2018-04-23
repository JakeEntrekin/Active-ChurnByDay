INSERT INTO jentrekin.factuseractivitydetail (row_number, userkey,  firstlogin, firstlogindatekey, lastlogin, lastlogindatekey, nextlogin, nextlogindatekey, gapsbetweenactivity, inactivedate, inactivedatekey, daysconsecutivelyloggedin, tasksusedpergroup, ValidLoginTo, ValidLoginToDateKey, churnflag)
WITH
  login_dates AS (
    SELECT sum(tasks_used) as tasks_used_per_day, user_id, userkey,
      date as login_date
    from jentrekin.tasksuseddetail
   -- where user_id = 104289
      group by user_id, userkey,
      date
    order by login_date
  )
  , login_date_groups AS (
    SELECT
      login_date,
      login_date - row_number() OVER (ORDER BY user_id, login_date) AS grp,
      tasks_used_per_day,
      user_id,
      userkey
    FROM login_dates
  )
  ,login_group_ranges as (
      SELECT
        min(login_date)                       AS FirstLogin,
        max(login_date)                          LastLogin,
        max(login_date) - min(login_date) + 1 AS [DaysConsecutivelyLoggedIn],
        row_number()
        OVER (
          ORDER BY user_id, grp  )                      as row_number,
        sum(tasks_used_per_day) as tasks_used_per_group,
        userkey,
        user_id
      FROM login_date_groups
      GROUP BY grp, userkey, user_id
  )

,
  login_date_ranges AS (
      select
        l.row_number,
        l.userkey,
        l.FirstLogin,
        cast(replace(cast(l.FirstLogin as varchar(10)), '-', '') as int)          as FirstLoginDateKey,
        l.LastLogin,
        cast(replace(cast(l.LastLogin as varchar(10)), '-', '') as int)           as LastLoginDateKey,
        l2.FirstLogin                                                             as NextLogin,
        cast(replace(cast(l2.FirstLogin as varchar(10)), '-', '') as int)         as NextLoginDateKey,
        cast(datediff(day, l.LastLogin, isnull(l2.FirstLogin, getdate())) as int) as GapsBetweenActivity,
        case when datediff(day, l.LastLogin, isnull(l2.FirstLogin, getdate())) > 28
          then dateadd(day, 28, l.lastlogin)
        else NULL END                                                             as InactiveDate,
        cast(replace(cast(case when datediff(day, l.LastLogin, isnull(l2.FirstLogin, getdate())) > 28
          then coalesce(l2.FirstLogin, dateadd(day, 28, l.lastlogin))
                          else NULL END as varchar(10)), '-', '') as int)         as InactiveDateKey,
        L.DaysConsecutivelyLoggedIn,
        l.tasks_used_per_group
      from login_group_ranges l LEFT JOIN login_group_ranges l2
          on l.row_number + 1 = l2.row_number
             and l.user_id = l2.user_id
      order by l.userkey, l.FirstLogin
  )
SELECT row_number, userkey, dateadd(millisecond, 1000, FirstLogin)  as FirstLogin, FirstLoginDateKey, LastLogin, LastLoginDateKey, NextLogin, NextLoginDateKey, GapsBetweenActivity,
  InactiveDate, InactiveDateKey, DaysConsecutivelyLoggedIn, tasks_used_per_group
  ,  case when InactiveDate is not null then InactiveDate else NextLogin END as ValidLoginTo
  , cast(replace(cast(case when InactiveDate is not null then InactiveDate else NextLogin END as varchar(10)), '-', '') as int) as ValidLoginToDateKey
, case when GapsBetweenActivity > 28 then 1 else 0 end as ChurnFlag
FROM login_date_ranges
order by FirstLogin;