defmodule Innovities.Workers.TariffPlanExpirationNotifier do
  use GenServer

  import Ecto.Query, only: [from: 2]

  alias Innovities.Repo

  alias Innovities.Accounts
  alias Innovities.Social
  alias Innovities.Social.Notification

  def start_link() do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    check_innovators_tariff_plan_subscription()
    check_organizations_tariff_plan_subscription()

    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 1000 * 60 * 60 * 12)
  end

  defp check_innovators_tariff_plan_subscription() do
    innovators =
      Accounts.list_innovators()

    innovators
    |> Enum.filter(fn i ->
      {:ok, expiry_date} =
        Timex.parse(i.tariff_expiry_date, "%Y-%m-%d", :strftime)

      diff =
        NaiveDateTime.diff(expiry_date, Timex.to_naive_datetime(Timex.now))

      if diff < (60 * 60 * 24 * 7) do
        true
      else
        false
      end
    end)
    |> Enum.reduce(0, fn i, _acc ->
      {:ok, expiry_date} =
        Timex.parse(i.tariff_expiry_date, "%Y-%m-%d", :strftime)

      diff =
        NaiveDateTime.diff(expiry_date, Timex.to_naive_datetime(Timex.now))

        cond do
          diff < (60 * 60 * 24 * 2) ->
            q =
              from n in Notification,
                where: n.addressed_to == ^i.id and n.addressed_to_is_org == false and n.notification_type == "2_DAY_TF_EXPIRY_NOTIF" and n.for_expiry_date == ^i.tariff_expiry_date,
                #order_by: [desc: o.rating],
                select: n
            searched_notif = Repo.all(q)
            if (length(searched_notif) == 0) do
              Social.create_notification(%{notification_type: "2_DAY_TF_EXPIRY_NOTIF", addressed_to: i.id, addressed_to_is_org: false, for_expiry_date: i.tariff_expiry_date, title: "Expiry notification", body: "2 days untill tariff plan subscription end."})
            end
          diff < (60 * 60 * 24 * 7) ->
            q =
              from n in Notification,
                where: n.addressed_to == ^i.id and n.addressed_to_is_org == false and n.notification_type == "7_DAY_TF_EXPIRY_NOTIF" and n.for_expiry_date == ^i.tariff_expiry_date,
                #order_by: [desc: o.rating],
                select: n
            searched_notif = Repo.all(q)
            if (length(searched_notif) == 0) do
              Social.create_notification(%{notification_type: "7_DAY_TF_EXPIRY_NOTIF", addressed_to: i.id, addressed_to_is_org: false, for_expiry_date: i.tariff_expiry_date, title: "Expiry notification", body: "7 days untill tariff plan subscription end."})
            end
        end
    end)

  end

  defp check_organizations_tariff_plan_subscription() do

    organizations =
      Accounts.list_organizations

    organizations
    |> Enum.filter(fn o ->
      {:ok, expiry_date} =
        Timex.parse(o.tariff_expiry_date, "%Y-%m-%d", :strftime)

      diff =
        NaiveDateTime.diff(expiry_date, Timex.to_naive_datetime(Timex.now))

      if diff < (60 * 60 * 24 * 7) do
        true
      else
        false
      end
    end)
    |> Enum.reduce(0, fn o, _acc ->
      {:ok, expiry_date} =
        Timex.parse(o.tariff_expiry_date, "%Y-%m-%d", :strftime)

      diff =
        NaiveDateTime.diff(expiry_date, Timex.to_naive_datetime(Timex.now))

        cond do
          diff < (60 * 60 * 24 * 2) ->
            q =
              from n in Notification,
                where: n.addressed_to == ^o.id and n.addressed_to_is_org == true and n.notification_type == "2_DAY_TF_EXPIRY_NOTIF" and n.for_expiry_date == ^o.tariff_expiry_date,
                #order_by: [desc: o.rating],
                select: n
            searched_notif = Repo.all(q)
            if (length(searched_notif) == 0) do
              Social.create_notification(%{notification_type: "2_DAY_TF_EXPIRY_NOTIF", addressed_to: o.id, addressed_to_is_org: true, for_expiry_date: o.tariff_expiry_date, title: "Expiry notification", body: "2 days untill tariff plan subscription end."})
            end
          diff < (60 * 60 * 24 * 7) ->
            q =
              from n in Notification,
                where: n.addressed_to == ^o.id and n.addressed_to_is_org == true and n.notification_type == "7_DAY_TF_EXPIRY_NOTIF" and n.for_expiry_date == ^o.tariff_expiry_date,
                #order_by: [desc: o.rating],
                select: n
            searched_notif = Repo.all(q)
            if (length(searched_notif) == 0) do
              Social.create_notification(%{notification_type: "7_DAY_TF_EXPIRY_NOTIF", addressed_to: o.id, addressed_to_is_org: true, for_expiry_date: o.tariff_expiry_date, title: "Expiry notification", body: "7 days untill tariff plan subscription end."})
            end
        end
    end)

  end
end
