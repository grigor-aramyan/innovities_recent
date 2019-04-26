defmodule Innovities.Tarrifs do
  @moduledoc """
  The Tarrifs context.
  """

  import Ecto.Query, warn: false
  alias Innovities.Repo

  alias Innovities.Tarrifs.InnovatorsPlan

  @doc """
  Returns the list of innovators_plans.

  ## Examples

      iex> list_innovators_plans()
      [%InnovatorsPlan{}, ...]

  """
  def list_innovators_plans do
    Repo.all(InnovatorsPlan)
  end

  @doc """
  Gets a single innovators_plan.

  Raises `Ecto.NoResultsError` if the Innovators plan does not exist.

  ## Examples

      iex> get_innovators_plan!(123)
      %InnovatorsPlan{}

      iex> get_innovators_plan!(456)
      ** (Ecto.NoResultsError)

  """
  def get_innovators_plan!(id), do: Repo.get!(InnovatorsPlan, id)

  @doc """
  Creates a innovators_plan.

  ## Examples

      iex> create_innovators_plan(%{field: value})
      {:ok, %InnovatorsPlan{}}

      iex> create_innovators_plan(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_innovators_plan(attrs \\ %{}) do
    %InnovatorsPlan{}
    |> InnovatorsPlan.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a innovators_plan.

  ## Examples

      iex> update_innovators_plan(innovators_plan, %{field: new_value})
      {:ok, %InnovatorsPlan{}}

      iex> update_innovators_plan(innovators_plan, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_innovators_plan(%InnovatorsPlan{} = innovators_plan, attrs) do
    innovators_plan
    |> InnovatorsPlan.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a InnovatorsPlan.

  ## Examples

      iex> delete_innovators_plan(innovators_plan)
      {:ok, %InnovatorsPlan{}}

      iex> delete_innovators_plan(innovators_plan)
      {:error, %Ecto.Changeset{}}

  """
  def delete_innovators_plan(%InnovatorsPlan{} = innovators_plan) do
    Repo.delete(innovators_plan)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking innovators_plan changes.

  ## Examples

      iex> change_innovators_plan(innovators_plan)
      %Ecto.Changeset{source: %InnovatorsPlan{}}

  """
  def change_innovators_plan(%InnovatorsPlan{} = innovators_plan) do
    InnovatorsPlan.changeset(innovators_plan, %{})
  end

  alias Innovities.Tarrifs.OrganizationsPlan

  @doc """
  Returns the list of organizations_plans.

  ## Examples

      iex> list_organizations_plans()
      [%OrganizationsPlan{}, ...]

  """
  def list_organizations_plans do
    Repo.all(OrganizationsPlan)
  end

  @doc """
  Gets a single organizations_plan.

  Raises `Ecto.NoResultsError` if the Organizations plan does not exist.

  ## Examples

      iex> get_organizations_plan!(123)
      %OrganizationsPlan{}

      iex> get_organizations_plan!(456)
      ** (Ecto.NoResultsError)

  """
  def get_organizations_plan!(id), do: Repo.get!(OrganizationsPlan, id)

  @doc """
  Creates a organizations_plan.

  ## Examples

      iex> create_organizations_plan(%{field: value})
      {:ok, %OrganizationsPlan{}}

      iex> create_organizations_plan(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_organizations_plan(attrs \\ %{}) do
    %OrganizationsPlan{}
    |> OrganizationsPlan.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a organizations_plan.

  ## Examples

      iex> update_organizations_plan(organizations_plan, %{field: new_value})
      {:ok, %OrganizationsPlan{}}

      iex> update_organizations_plan(organizations_plan, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_organizations_plan(%OrganizationsPlan{} = organizations_plan, attrs) do
    organizations_plan
    |> OrganizationsPlan.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a OrganizationsPlan.

  ## Examples

      iex> delete_organizations_plan(organizations_plan)
      {:ok, %OrganizationsPlan{}}

      iex> delete_organizations_plan(organizations_plan)
      {:error, %Ecto.Changeset{}}

  """
  def delete_organizations_plan(%OrganizationsPlan{} = organizations_plan) do
    Repo.delete(organizations_plan)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking organizations_plan changes.

  ## Examples

      iex> change_organizations_plan(organizations_plan)
      %Ecto.Changeset{source: %OrganizationsPlan{}}

  """
  def change_organizations_plan(%OrganizationsPlan{} = organizations_plan) do
    OrganizationsPlan.changeset(organizations_plan, %{})
  end
end
