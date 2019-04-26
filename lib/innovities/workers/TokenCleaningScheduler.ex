defmodule Innovities.Workers.TokenCleaningScheduler do
  use GenServer

  import Ecto.Query, only: [from: 2]

  alias Innovities.Repo
  alias Innovities.Auth
  alias Innovities.Auth.Token

  def start_link() do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do

    query = from t in "tokens",
        where: t.id > 0,
        select: [t.id, t.updated_at]
    result = Repo.all(query)
    compare_times_and_delete(result)

    schedule_work()
    {:noreply, state}
  end

  defp compare_times_and_delete([]) do

  end
  defp compare_times_and_delete([head | tail]) do
    [id | time_list] = head

    [time|_empty] = time_list

    diff = NaiveDateTime.diff(Timex.to_naive_datetime(Timex.now), Timex.to_naive_datetime(time))

    if diff > (1 * 60 * 60) do
      case Repo.get(Token, id) do
        t = %Token{} ->
          Auth.delete_token(t)
        _ ->
          {:ok, %Token{}}
      end
    end
    compare_times_and_delete(tail)
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 1000 * 60 * 60 * 1)
  end
end
