IF NOT EXISTS (SELECT * FROM sys.objects O JOIN sys.schemas S ON O.schema_id = S.schema_id WHERE O.NAME = '[loans_pred]' AND O.TYPE = 'U' AND S.NAME = '[dbo]')
CREATE TABLE [dbo].[loans_pred]
	(
	 [row_num] bigint,
	 [delinq_2yrs] float,
	 [dti] float,
	 [inq_last_6mths] float,
	 [installment] float,
	 [int_rate] float,
	 [loan_amnt] bigint,
	 [num_tl_90g_dpd_24m] float,
	 [pub_rec] float,
	 [log_annual_inc] float,
	 [log_avg_cur_bal] float,
	 [emp_length_5to9_years] bigint,
	 [emp_length_10_years_and_more] bigint,
	 [emp_length_na] bigint,
	 [grade_2] bigint,
	 [grade_3] bigint,
	 [grade_4] bigint,
	 [grade_5] bigint,
	 [grade_6] bigint,
	 [grade_7] bigint,
	 [home_ownership_OTHER] bigint,
	 [home_ownership_OWN] bigint,
	 [home_ownership_RENT] bigint,
	 [purpose_debt_consolidation] bigint,
	 [purpose_other] bigint,
	 [purpose_personal] bigint,
	 [term_60_months] bigint,
	 [pred] bigint
	)
WITH
	(
	DISTRIBUTION = ROUND_ROBIN,
	 HEAP
	 -- CLUSTERED COLUMNSTORE INDEX
	)
GO

--Uncomment the 4 lines below to create a stored procedure for data pipeline orchestration​
--CREATE PROC bulk_load_[loans_pred]
--AS
--BEGIN
COPY INTO [dbo].[loans_pred]
(row_num 1, delinq_2yrs 2, dti 3, inq_last_6mths 4, installment 5, int_rate 6, loan_amnt 7, num_tl_90g_dpd_24m 8, pub_rec 9, log_annual_inc 10, log_avg_cur_bal 11, emp_length_5to9_years 12, emp_length_10_years_and_more 13, emp_length_na 14, grade_2 15, grade_3 16, grade_4 17, grade_5 18, grade_6 19, grade_7 20, home_ownership_OTHER 21, home_ownership_OWN 22, home_ownership_RENT 23, purpose_debt_consolidation 24, purpose_other 25, purpose_personal 26, term_60_months 27, pred 28)
FROM 'https://azureaihackathon.dfs.core.windows.net/azureaihackathon/lr_y_pred_merge.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 0
	,FIRSTROW = 2
	,ERRORFILE = 'https://azureaihackathon.dfs.core.windows.net/azureaihackathon/'
	,IDENTITY_INSERT = 'OFF'
)
--END
GO

SELECT TOP 100 * FROM [dbo].[loans_pred]
GO