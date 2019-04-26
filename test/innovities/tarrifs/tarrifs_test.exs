defmodule Innovities.TarrifsTest do
  use Innovities.DataCase

  alias Innovities.Tarrifs

  describe "innovators_plans" do
    alias Innovities.Tarrifs.InnovatorsPlan

    @valid_attrs %{ideas_count: 42, monthly_pay: 42, name: "some name", organization_connection_count: 42, region: "some region", yearly_pay: 42}
    @update_attrs %{ideas_count: 43, monthly_pay: 43, name: "some updated name", organization_connection_count: 43, region: "some updated region", yearly_pay: 43}
    @invalid_attrs %{ideas_count: nil, monthly_pay: nil, name: nil, organization_connection_count: nil, region: nil, yearly_pay: nil}

    def innovators_plan_fixture(attrs \\ %{}) do
      {:ok, innovators_plan} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tarrifs.create_innovators_plan()

      innovators_plan
    end

    test "list_innovators_plans/0 returns all innovators_plans" do
      innovators_plan = innovators_plan_fixture()
      assert Tarrifs.list_innovators_plans() == [innovators_plan]
    end

    test "get_innovators_plan!/1 returns the innovators_plan with given id" do
      innovators_plan = innovators_plan_fixture()
      assert Tarrifs.get_innovators_plan!(innovators_plan.id) == innovators_plan
    end

    test "create_innovators_plan/1 with valid data creates a innovators_plan" do
      assert {:ok, %InnovatorsPlan{} = innovators_plan} = Tarrifs.create_innovators_plan(@valid_attrs)
      assert innovators_plan.ideas_count == 42
      assert innovators_plan.monthly_pay == 42
      assert innovators_plan.name == "some name"
      assert innovators_plan.organization_connection_count == 42
      assert innovators_plan.region == "some region"
      assert innovators_plan.yearly_pay == 42
    end

    test "create_innovators_plan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tarrifs.create_innovators_plan(@invalid_attrs)
    end

    test "update_innovators_plan/2 with valid data updates the innovators_plan" do
      innovators_plan = innovators_plan_fixture()
      assert {:ok, innovators_plan} = Tarrifs.update_innovators_plan(innovators_plan, @update_attrs)
      assert %InnovatorsPlan{} = innovators_plan
      assert innovators_plan.ideas_count == 43
      assert innovators_plan.monthly_pay == 43
      assert innovators_plan.name == "some updated name"
      assert innovators_plan.organization_connection_count == 43
      assert innovators_plan.region == "some updated region"
      assert innovators_plan.yearly_pay == 43
    end

    test "update_innovators_plan/2 with invalid data returns error changeset" do
      innovators_plan = innovators_plan_fixture()
      assert {:error, %Ecto.Changeset{}} = Tarrifs.update_innovators_plan(innovators_plan, @invalid_attrs)
      assert innovators_plan == Tarrifs.get_innovators_plan!(innovators_plan.id)
    end

    test "delete_innovators_plan/1 deletes the innovators_plan" do
      innovators_plan = innovators_plan_fixture()
      assert {:ok, %InnovatorsPlan{}} = Tarrifs.delete_innovators_plan(innovators_plan)
      assert_raise Ecto.NoResultsError, fn -> Tarrifs.get_innovators_plan!(innovators_plan.id) end
    end

    test "change_innovators_plan/1 returns a innovators_plan changeset" do
      innovators_plan = innovators_plan_fixture()
      assert %Ecto.Changeset{} = Tarrifs.change_innovators_plan(innovators_plan)
    end
  end

  describe "organizations_plans" do
    alias Innovities.Tarrifs.OrganizationsPlan

    @valid_attrs %{complete_ideas_count: 42, innovator_connection_count: 42, monthly_pay: 42, name: "some name", region: "some region", yearly_pay: 42}
    @update_attrs %{complete_ideas_count: 43, innovator_connection_count: 43, monthly_pay: 43, name: "some updated name", region: "some updated region", yearly_pay: 43}
    @invalid_attrs %{complete_ideas_count: nil, innovator_connection_count: nil, monthly_pay: nil, name: nil, region: nil, yearly_pay: nil}

    def organizations_plan_fixture(attrs \\ %{}) do
      {:ok, organizations_plan} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tarrifs.create_organizations_plan()

      organizations_plan
    end

    test "list_organizations_plans/0 returns all organizations_plans" do
      organizations_plan = organizations_plan_fixture()
      assert Tarrifs.list_organizations_plans() == [organizations_plan]
    end

    test "get_organizations_plan!/1 returns the organizations_plan with given id" do
      organizations_plan = organizations_plan_fixture()
      assert Tarrifs.get_organizations_plan!(organizations_plan.id) == organizations_plan
    end

    test "create_organizations_plan/1 with valid data creates a organizations_plan" do
      assert {:ok, %OrganizationsPlan{} = organizations_plan} = Tarrifs.create_organizations_plan(@valid_attrs)
      assert organizations_plan.complete_ideas_count == 42
      assert organizations_plan.innovator_connection_count == 42
      assert organizations_plan.monthly_pay == 42
      assert organizations_plan.name == "some name"
      assert organizations_plan.region == "some region"
      assert organizations_plan.yearly_pay == 42
    end

    test "create_organizations_plan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tarrifs.create_organizations_plan(@invalid_attrs)
    end

    test "update_organizations_plan/2 with valid data updates the organizations_plan" do
      organizations_plan = organizations_plan_fixture()
      assert {:ok, organizations_plan} = Tarrifs.update_organizations_plan(organizations_plan, @update_attrs)
      assert %OrganizationsPlan{} = organizations_plan
      assert organizations_plan.complete_ideas_count == 43
      assert organizations_plan.innovator_connection_count == 43
      assert organizations_plan.monthly_pay == 43
      assert organizations_plan.name == "some updated name"
      assert organizations_plan.region == "some updated region"
      assert organizations_plan.yearly_pay == 43
    end

    test "update_organizations_plan/2 with invalid data returns error changeset" do
      organizations_plan = organizations_plan_fixture()
      assert {:error, %Ecto.Changeset{}} = Tarrifs.update_organizations_plan(organizations_plan, @invalid_attrs)
      assert organizations_plan == Tarrifs.get_organizations_plan!(organizations_plan.id)
    end

    test "delete_organizations_plan/1 deletes the organizations_plan" do
      organizations_plan = organizations_plan_fixture()
      assert {:ok, %OrganizationsPlan{}} = Tarrifs.delete_organizations_plan(organizations_plan)
      assert_raise Ecto.NoResultsError, fn -> Tarrifs.get_organizations_plan!(organizations_plan.id) end
    end

    test "change_organizations_plan/1 returns a organizations_plan changeset" do
      organizations_plan = organizations_plan_fixture()
      assert %Ecto.Changeset{} = Tarrifs.change_organizations_plan(organizations_plan)
    end
  end
end
