defmodule CoexWeb.PersonsLive do
  use CoexWeb, :live_view

  use CoexWeb.Ticker

  def mount(_, _, socket) do
    if connected?(socket), do: tick(self(), :minutes)
    {:ok, socket}
  end
end
