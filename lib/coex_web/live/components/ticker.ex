defmodule CoexWeb.Ticker do
  defmacro __using__(_) do
    quote do
      import CoexWeb.Ticker, only: [tick: 1, tick: 2]

      @impl true
      def handle_info({:tick, pid, precision}, socket) do
        tick(self(), precision)
        {:noreply, socket}
      end
    end
  end

  def tick(pid, precision \\ :seconds) do
    now = NaiveDateTime.utc_now()

    Phoenix.LiveView.send_update(pid, DateTimeComponent, %{
      id: "clock",
      now: now,
      precision: precision
    })

    interval =
      case precision do
        :minutes ->
          if now.second == 0, do: :timer.minutes(1), else: :timer.seconds(60 - now.second)

        :seconds ->
          :timer.seconds(1)
      end

    Process.send_after(pid, {:tick, pid, precision}, interval)
  end
end
