defmodule GoliathPesistence do
  @moduledoc """
  Module for charges by credits
  """

  @doc """
  Hello world.

  ## Examples

      iex> GoliathPesistence.hello()
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
    :date,
    :balance,
    :delay_days,
    :user_id,
    :amount_due,
    :extract_date,
    :contract_id,
    :customer_id
  ]
  @optional_fields [:amount_debit, :reference, :charges, :is_paid]

  schema "credits_charges" do
    field(:date, :date)
    field(:balance, :decimal, default: 0.00)
    field(:delay_days, :float, default: 0)
    field(:amount_due, :decimal, default: 0.00)
    field(:extract_date, :date)
    field(:contract_id, :integer, default: 0)

    field(:amount_debit, :decimal, default: 0.00)
    field(:reference, :string, size: 45)
    field(:charges, :integer, default: 0)
    field(:attempts, :integer, default: 0)
    field(:is_paid, :boolean, default: false)

    belongs_to(:user, User)
    belongs_to(:user_intelligential, Intelligential, foreign_key: :customer_id)

    timestamps()
  end

  def create_changeset(credits_charges, params) do
    credits_charges
    |> update_changeset(params)
    |> validate_required(@required_fields)
  end

  def update_changeset(credits_charges, params) do
    credits_charges
    |> cast(params, @required_fields)
    |> cast(params, @optional_fields)
  end

  def create(attrs) do
    %Charges{}
    |> create_changeset(attrs)
    |> Repo.insert()
  end

  def update(attrs) do
    %Charges{}
    |> update_changeset(attrs)
    |> Repo.update()
  end

  def set_amount_debit(credits_charges, amount_debit) do
    credits_charges
    |> Ecto.Changeset.change(charges: credits_charges.charges + 1)
    |> Ecto.Changeset.change(
      amount_debit: Decimal.add(credits_charges.amount_debit, amount_debit)
    )
    |> Ecto.Changeset.change(
      is_paid:
        Decimal.compare(
          credits_charges.amount_due,
          Decimal.add(credits_charges.amount_debit, amount_debit)
        ) != Decimal.new("1")
    )
    |> Repo.update()
  end

  def set_attempts(credits_charges) do
    credits_charges
    |> Ecto.Changeset.change(attempts: credits_charges.attempts + 1)
    |> Repo.update()
  end

  def get(user_id, id) do
    query =
      from(c in Credits,
        join: cpa in "credits_pre_approved",
        on: cpa.credit_id == c.id,
        where:
          c.id == type(^id, :integer) and
            cpa.user_id == type(^user_id, :integer),
        preload: ^get_list_preload()
      )

    case Repo.one(query) do
      nil ->
        {:error, gettext("credit id does not exist")}

      credit ->
        {:ok, credit}
    end
  end

  def get_all(extract_date) do
    query =
      from(c in Charges,
        preload: ^get_list_preload()
      )

    Repo.all(query)
  end

  def get_by_extract_date(extract_date, start_days, fin_days) do
    query =
      from(c in Charges,
        where:
          c.extract_date == ^extract_date and
            c.amount_due > 0 and
            c.is_paid == false and
            c.delay_days >= ^start_days and
            c.delay_days <= ^fin_days,
        order_by: [c.delay_days, c.attempts],
        preload: ^get_list_preload()
      )

    Repo.all(query)
  end

  def get_by_contract_id(contract_id, extract_date) do
    query =
      from(c in Charges,
        where:
          c.contract_id == ^contract_id and
            c.extract_date == ^extract_date,
        preload: ^get_list_preload()
      )

    Repo.all(query)
  end

  def get_by_report(extract_date, reference \\ nil) do
    query =
      if reference == nil do
        from(c in Charges,
          where:
            c.extract_date == ^extract_date and
              c.amount_debit > 0 and
              is_nil(c.reference)
        )
      else
        from(c in Charges,
          where:
            c.extract_date == ^extract_date and
              c.amount_debit > 0 and
              c.reference == ^reference
        )
      end

    Repo.all(query)
  end

  def get_list_preload() do
    [:user]
  end
end
