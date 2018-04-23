create or replace view viewDimAccount as
SELECT dimaccount.AccountKey, dimaccount.account_id, dimaccount.accountdescriptrion, dimaccount.insertdate, dimaccount.updatedate
FROM dimaccount
UNION ALL SELECT -1 AS AccountKey, -1 AS account_id, 'N/A' AS accountdescriptrion, getdate() AS insertdate
, getdate() AS updatedate; --handle unknown members; RS does not allow for IDENTITY_INSERTS