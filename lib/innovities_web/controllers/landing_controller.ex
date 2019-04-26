defmodule InnovitiesWeb.LandingController do
  use InnovitiesWeb, :controller

  alias Innovities.Repo
  alias Innovities.Accounts
  alias Innovities.Accounts.Innovator
  alias Innovities.Content
  alias Innovities.Content.Idea
  alias Innovities.Tarrifs.InnovatorsPlan

  def admin_login(conn, %{"first_password" => first_password, "second_password" => second_password} = _params) do
    case first_password == "kd2!!kdA89K^ena" and second_password == "82*%ioan,KAGE" do
      true ->
        innovators = Accounts.list_innovators
        data_list = pack_innovators(innovators)

        render(conn, "preregs_list.json", reg_data: data_list, error: "")
      false ->
        render(conn, "preregs_list.json", reg_data: [], error: "Չհաջողվեց մուտք գործել!")
    end
  end

  def promotion_registration(conn, %{"full_name" => _full_name, "email" => _email, "prefered_organization"
    => _prefered_organization, "short_description" => short_description} = params) do

    premium_plan = Repo.get_by!(InnovatorsPlan, name: "Premium")

    new_innovator =
      params
      |> Map.put("password", "sec#re7t1K")
      |> Map.put("innovators_plan_id", premium_plan.id)
      |> Map.delete("short_description")

    case Accounts.create_innovator(new_innovator) do
      {:ok, inno = %Innovator{}} ->
        if (String.length(short_description) == 0) do
          render(conn, "promo_registration.json", innovator: inno, idea: %Idea{innovator_id: inno.id, short_description: ""}, error: "")
        else
          new_idea =
            %{}
            |> Map.put(:innovator_id, inno.id)
            |> Map.put(:short_description, short_description)

          case Content.create_idea(new_idea) do
            {:ok, i = %Idea{}} ->
              render(conn, "promo_registration.json", innovator: inno, idea: i, error: "")
            {:error, _} ->
              render(conn, "promo_registration.json", innovator: inno, idea: %Idea{innovator_id: inno.id, short_description: ""}, error: "Չկարողացա գրանցել Ձեր գաղափարը: Կապվեք մեզ հետ, խնդրում եմ")
          end

        end
      {:error, _} ->
        render(conn, "promo_registration.json", innovator: %Innovator{full_name: "", email: "", prefered_organization: ""}, idea: %Idea{innovator_id: 0, short_description: ""}, error: "Չկարողացա գրանցել Ձեր տվյալները: Կապվեք մեզ հետ, խնդրում եմ")
    end
  end

  defp pack_innovators([]) do
    []
  end

  defp pack_innovators( [h = %Innovator{} | t] ) do
    {:ok, formatted_date} =
      Timex.to_naive_datetime(h.inserted_at)
      |> Timex.format("%Y-%m-%d %H:%M", :strftime)

    case  Content.get_ideas_by_innovator_id(h.id) do
      idea = %Idea{} ->
        [ %{ id: h.id, full_name: h.full_name, email: h.email, prefered_organization: h.prefered_organization, idea_id: idea.id, short_description: idea.short_description, register_date: formatted_date } ] ++ pack_innovators(t)
      nil ->
        [ %{ id: h.id, full_name: h.full_name, email: h.email, prefered_organization: h.prefered_organization, idea_id: 0, short_description: "", register_date: formatted_date } ] ++ pack_innovators(t)
    end

  end

end
