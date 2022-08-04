defmodule Goliath.Credits.Persistence.Db.Quota do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]
  import Goliath.Gettext

  alias Goliath.Credits
  alias Goliath.Credits.Charges
  alias Goliath.User
  alias Goliath.User.Intelligential
  alias Goliath.Repo

  @required_fields [
    :loan_code,
    :plan_number,
    :quota_sec,
    :start_date,
    :quota_delayed_days,
    :quota_state,
    :balance_sub_code,
    :delayed_quota_history_days,
    :prevision_amount,
    :INTE_adjust
  ]
  @optional_fields [:due_date, :last_quota_state, :last_payment_date, :bill_number]

  schema "quota_clients" do
    field(:loan_code, :string )
  end
end
