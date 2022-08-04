defmodule GoliathCreditsPersistence do
  @moduledoc """
    Type mix ecto.migrate at the root of the project and and you'll end with these two tables 

  goliath_credits_persistence_repo=# \dS clients_quota
                               Table "public.clients_quota"
         Column         |              Type              | Collation | Nullable | Default 
------------------------+--------------------------------+-----------+----------+---------
 loan_code              | character varying(19)          |           | not null | 
 plan_number            | integer                        |           | not null | 0
 quota_sec              | integer                        |           | not null | 0
 concept_code           | character varying(5)           |           | not null | 
 user_code              | character varying(15)          |           | not null | 
 calc_number_days       | integer                        |           | not null | 0
 quota_amount           | numeric                        |           | not null | 0.0
 earned_amount          | numeric                        |           | not null | 0.0
 paid_amount            | numeric                        |           | not null | 0.0
 condoned_amount        | numeric                        |           | not null | 0.0
 payment_sec            | integer                        |           | not null | 0
 payment_date           | timestamp(0) without time zone |           |          | 
 concept_state          | character varying(10)          |           | not null | 
 previous_paid_amount   | numeric                        |           |          | 0.0
 previous_concept_state | character varying(10)          |           |          | 
 previous_payment_date  | timestamp(0) without time zone |           |          | 
 previous_sec_payment   | integer                        |           |          | 0
 last_payment_penalty   | bytea                          |           |          | 
 previous_earned_amount | numeric                        |           |          | 0.0
 debt_balance           | numeric                        |           | not null | 0.0
 office_code            | character varying(4)           |           | not null | 
Indexes:
    "clients_quota_pkey" PRIMARY KEY, btree (loan_code, plan_number, quota_sec, concept_code)



and ....

goliath_credits_persistence_repo=# \dS quota
                                      Table "public.quota"
            Column             |              Type              | Collation | Nullable | Default 
-------------------------------+--------------------------------+-----------+----------+---------
 loan_code                     | character varying(19)          |           | not null | 
 plan_number                   | integer                        |           | not null | 0
 quota_sec                     | integer                        |           | not null | 0
 start_utc_datetime            | timestamp(0) without time zone |           | not null | 
 due_utc_datetime              | timestamp(0) without time zone |           | not null | 
 payment_utc_datetime          | timestamp(0) without time zone |           |          | 
 quota_delayed_days            | integer                        |           | not null | 0
 quota_state                   | character varying(10)          |           | not null | 
 balance_sub_code              | character varying(15)          |           | not null | 
 delayed_quota_history_days    | integer                        |           | not null | 
 previous_quota_state          | character varying(10)          |           |          | 
 previous_payment_utc_datetime | timestamp(0) without time zone |           |          | 
 previous_state_sub_code       | character varying(7)           |           | not null | 
 prevision_amount              | numeric                        |           | not null | 0.0
 INTE_adjust                   | bytea                          |           | not null | 
 bill_number                   | character varying(1)           |           | not null | 
Indexes:
    "quota_pkey" PRIMARY KEY, btree (loan_code, plan_number, quota_sec)

  """

  @doc """


  """

  def hello() do
    :hello
  end
  
end
