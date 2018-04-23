create or replace view viewdimusers as
SELECT dimusers.userkey, dimusers.user_id, dimusers.userdescriptrion, dimusers.insertdate, dimusers.updatedate 
FROM dimusers 
UNION ALL SELECT -1 AS userkey, -1 AS user_id, 'N/A' AS userdescriptrion, getdate() AS insertdate, getdate() AS updatedate; --handle unknown members; RS does not allow for IDENTITY_INSERTS
