defmodule Innovities.AccountsTest do
  use Innovities.DataCase

  alias Innovities.Accounts

  describe "innovators" do
    alias Innovities.Accounts.Innovator

    @valid_attrs %{country: "some country", email: "some email", full_name: "some full_name", generated_ideas_count: 42, organization_connection_count: 42, password: "some password", picture_uri: "some picture_uri"}
    @update_attrs %{country: "some updated country", email: "some updated email", full_name: "some updated full_name", generated_ideas_count: 43, organization_connection_count: 43, password: "some updated password", picture_uri: "some updated picture_uri"}
    @invalid_attrs %{country: nil, email: nil, full_name: nil, generated_ideas_count: nil, organization_connection_count: nil, password: nil, picture_uri: nil}

    def innovator_fixture(attrs \\ %{}) do
      {:ok, innovator} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_innovator()

      innovator
    end

    test "list_innovators/0 returns all innovators" do
      innovator = innovator_fixture()
      assert Accounts.list_innovators() == [innovator]
    end

    test "get_innovator!/1 returns the innovator with given id" do
      innovator = innovator_fixture()
      assert Accounts.get_innovator!(innovator.id) == innovator
    end

    test "create_innovator/1 with valid data creates a innovator" do
      assert {:ok, %Innovator{} = innovator} = Accounts.create_innovator(@valid_attrs)
      assert innovator.country == "some country"
      assert innovator.email == "some email"
      assert innovator.full_name == "some full_name"
      assert innovator.generated_ideas_count == 42
      assert innovator.organization_connection_count == 42
      assert innovator.password == "some password"
      assert innovator.picture_uri == "some picture_uri"
    end

    test "create_innovator/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_innovator(@invalid_attrs)
    end

    test "update_innovator/2 with valid data updates the innovator" do
      innovator = innovator_fixture()
      assert {:ok, innovator} = Accounts.update_innovator(innovator, @update_attrs)
      assert %Innovator{} = innovator
      assert innovator.country == "some updated country"
      assert innovator.email == "some updated email"
      assert innovator.full_name == "some updated full_name"
      assert innovator.generated_ideas_count == 43
      assert innovator.organization_connection_count == 43
      assert innovator.password == "some updated password"
      assert innovator.picture_uri == "some updated picture_uri"
    end

    test "update_innovator/2 with invalid data returns error changeset" do
      innovator = innovator_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_innovator(innovator, @invalid_attrs)
      assert innovator == Accounts.get_innovator!(innovator.id)
    end

    test "delete_innovator/1 deletes the innovator" do
      innovator = innovator_fixture()
      assert {:ok, %Innovator{}} = Accounts.delete_innovator(innovator)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_innovator!(innovator.id) end
    end

    test "change_innovator/1 returns a innovator changeset" do
      innovator = innovator_fixture()
      assert %Ecto.Changeset{} = Accounts.change_innovator(innovator)
    end
  end

  describe "organizations" do
    alias Innovities.Accounts.Organization

    @valid_attrs %{complete_ideas_count: 42, country: "some country", email: "some email", innovator_connection_count: 42, logo_uri: "some logo_uri", name: "some name", password: "some password"}
    @update_attrs %{complete_ideas_count: 43, country: "some updated country", email: "some updated email", innovator_connection_count: 43, logo_uri: "some updated logo_uri", name: "some updated name", password: "some updated password"}
    @invalid_attrs %{complete_ideas_count: nil, country: nil, email: nil, innovator_connection_count: nil, logo_uri: nil, name: nil, password: nil}

    def organization_fixture(attrs \\ %{}) do
      {:ok, organization} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_organization()

      organization
    end

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert Accounts.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Accounts.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} = Accounts.create_organization(@valid_attrs)
      assert organization.complete_ideas_count == 42
      assert organization.country == "some country"
      assert organization.email == "some email"
      assert organization.innovator_connection_count == 42
      assert organization.logo_uri == "some logo_uri"
      assert organization.name == "some name"
      assert organization.password == "some password"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, organization} = Accounts.update_organization(organization, @update_attrs)
      assert %Organization{} = organization
      assert organization.complete_ideas_count == 43
      assert organization.country == "some updated country"
      assert organization.email == "some updated email"
      assert organization.innovator_connection_count == 43
      assert organization.logo_uri == "some updated logo_uri"
      assert organization.name == "some updated name"
      assert organization.password == "some updated password"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_organization(organization, @invalid_attrs)
      assert organization == Accounts.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Accounts.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Accounts.change_organization(organization)
    end
  end
end
