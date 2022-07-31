defmodule GoliathCreditsPersistence do
  @moduledoc """
  Documentation for `GoliathCreditsPersistence`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> GoliathCreditsPersistence.hello()
      :world

  """

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

  schema "quota" do
    field(:loan_code, :string)
    field(:plan_number, :integer, default: 0)
    field(:quota_sec, :integer, default: 0)
    field(:start_date, :date)
    field(:due_date, :date)
    field(:payment_date, :date)
    field(:quota_delayed_days, :integer, default: 0)
    field(:quota_state, :string)
    field(:balance_sub_code, :string)
    field(:delayed_quota_history_days, :integer)
    field(:last_quota_state, :string)
    field(:last_payment_date, :date)
    field(:last_state_sub_code, :string)
    field(:prevision_amount, :decimal, default: 0.00)
    field(:INTE_adjust, :binary)
    field(:bill_number, :string)
  end


  
  
end
