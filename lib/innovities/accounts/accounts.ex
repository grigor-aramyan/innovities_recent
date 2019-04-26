defmodule Innovities.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Innovities.Repo

  alias Innovities.Accounts.{Innovator, Organization}
  alias Innovities.Social.Connection
  alias Innovities.Tarrifs

  @doc """
  Checks tariff plan subscription data.

  ## Examples

      iex> check_subscription(good_parameters)
      {:ok, remaining_ideas_count, remaining_connections_count, tp_region_scheme, users_region}

      iex> check_subscription(good_parameters_but_expired_subscription)
      {:ok, :expired}

      iex> check_subscription(bad_parameters)
      {:error, "Unidentified user"}

  """

  def check_subscription(user_id, is_org) do
    user =
      if is_org do
        case Repo.get(Organization, user_id) do
          o = %Organization{} -> o
          nil -> nil
        end
      else
        case Repo.get(Innovator, user_id) do
          i = %Innovator{} -> i
          nil -> nil
        end
      end

      currentDate =
        DateTime.utc_now()
        |> to_string()
        |> String.split(" ")
        |> hd()

    case user do
      u = %Organization{} ->
        if (currentDate > u.tariff_expiry_date) do
          {:ok, :expired}
        else
          tp = Tarrifs.get_organizations_plan!(u.organizations_plan_id)
          remaining_ideas_count =
            tp.complete_ideas_count - u.complete_ideas_count
          remaining_connections_count =
            tp.innovator_connection_count - u.innovator_connection_count
          active_area =
            case tp.region do
              "Current country" -> u.country
              "Current region" -> u.region
              "Current continent" -> u.continent
              "Worldwide" -> "Worldwide"
              true -> "Worldwide"
            end
          {:ok, remaining_ideas_count, remaining_connections_count, tp.region, active_area}
        end
      i = %Innovator{} ->
        if (currentDate > i.tariff_expiry_date) do
          {:ok, :expired}
        else
          tp = Tarrifs.get_innovators_plan!(i.innovators_plan_id)
          remaining_ideas_count =
            tp.ideas_count - i.generated_ideas_count
          remaining_connections_count =
            tp.organization_connection_count - i.organization_connection_count
          active_area =
            case tp.region do
              "Current country" -> i.country
              "Current region" -> i.region
              "Current continent" -> i.continent
              "Worldwide" -> "Worldwide"
              true -> "Worldwide"
            end
          {:ok, remaining_ideas_count, remaining_connections_count, tp.region, active_area}
        end
      nil ->
        {:error, "Unidentified user"}
    end

  end

  @doc """
  Returns the list of innovators.

  ## Examples

      iex> list_innovators()
      [%Innovator{}, ...]

  """
  def list_innovators do
    Repo.all(Innovator)
  end

  @doc """
  Gets a single innovator.

  Raises `Ecto.NoResultsError` if the Innovator does not exist.

  ## Examples

      iex> get_innovator!(123)
      %Innovator{}

      iex> get_innovator!(456)
      ** (Ecto.NoResultsError)

  """
  def get_innovator!(id), do: Repo.get!(Innovator, id)

  @doc """
  Creates a innovator.

  ## Examples

      iex> create_innovator(%{field: value})
      {:ok, %Innovator{}}

      iex> create_innovator(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_innovator(attrs \\ %{}) do
    %Innovator{}
    |> Innovator.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a innovator.

  ## Examples

      iex> update_innovator(innovator, %{field: new_value})
      {:ok, %Innovator{}}

      iex> update_innovator(innovator, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_innovator(%Innovator{} = innovator, attrs) do
    innovator
    |> Innovator.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Innovator.

  ## Examples

      iex> delete_innovator(innovator)
      {:ok, %Innovator{}}

      iex> delete_innovator(innovator)
      {:error, %Ecto.Changeset{}}

  """
  def delete_innovator(%Innovator{} = innovator) do
    Repo.delete(innovator)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking innovator changes.

  ## Examples

      iex> change_innovator(innovator)
      %Ecto.Changeset{source: %Innovator{}}

  """
  def change_innovator(%Innovator{} = innovator) do
    Innovator.changeset(innovator, %{})
  end

  alias Innovities.Accounts.Organization

  @doc """
  Returns the list of organizations.

  ## Examples

      iex> list_organizations()
      [%Organization{}, ...]

  """
  def list_organizations do
    Repo.all(Organization)
  end

  @doc """
  Gets a single organization.

  Raises `Ecto.NoResultsError` if the Organization does not exist.

  ## Examples

      iex> get_organization!(123)
      %Organization{}

      iex> get_organization!(456)
      ** (Ecto.NoResultsError)

  """
  def get_organization!(id), do: Repo.get!(Organization, id)

  @doc """
  Creates a organization.

  ## Examples

      iex> create_organization(%{field: value})
      {:ok, %Organization{}}

      iex> create_organization(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_organization(attrs \\ %{}) do
    %Organization{}
    |> Organization.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a organization.

  ## Examples

      iex> update_organization(organization, %{field: new_value})
      {:ok, %Organization{}}

      iex> update_organization(organization, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_organization(%Organization{} = organization, attrs) do
    organization
    |> Organization.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Organization.

  ## Examples

      iex> delete_organization(organization)
      {:ok, %Organization{}}

      iex> delete_organization(organization)
      {:error, %Ecto.Changeset{}}

  """
  def delete_organization(%Organization{} = organization) do
    Repo.delete(organization)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking organization changes.

  ## Examples

      iex> change_organization(organization)
      %Ecto.Changeset{source: %Organization{}}

  """
  def change_organization(%Organization{} = organization) do
    Organization.changeset(organization, %{})
  end

  @doc """
  Returns true if there is connection between organization and innovator with given ids, false otherwise.

  """
  def connected?(organization_id, innovator_id) do
    q =
      from c in Connection,
        where: (c.sender_id == ^organization_id and c.sender_is_organization == true and c.receiver_id == ^innovator_id and c.receiver_is_organization == false) or
          (c.sender_id == ^innovator_id and c.sender_is_organization == false and c.receiver_id == ^organization_id and c.receiver_is_organization == true),
        #order_by: [desc: i.rating],
        #distinct: [msg.from, msg.sender_is_organization],
        select: c
    connections = Repo.all(q)

    if (length(connections) > 0) do
      true
    else
      false
    end
  end
end
