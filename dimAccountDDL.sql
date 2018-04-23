CREATE TABLE jentrekin.dimAccount (
  AccountKey          bigint IDENTITY (1, 1) NOT NULL,
  account_id          bigint                 NOT NULL,
  AccountDescriptrion VARCHAR(255),
  InsertDate          date,
  UpdateDate          date,
  PRIMARY KEY (AccountKey) )
    sortkey(AccountKey);