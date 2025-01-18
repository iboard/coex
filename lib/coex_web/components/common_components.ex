defmodule CoexWeb.CommonComponents do
  @moduledoc """
  Provides common UI components.
  """

  use Phoenix.Component
  use Gettext, backend: CoexWeb.Gettext

  # alias Phoenix.LiveView.JS

  @doc """
  Display the current date

  ## Examples

      <.current_date />

  """
  def current_date(assigns) do
    ~H"""
    <div>
      {NaiveDateTime.utc_now()
      |> to_string()
      |> String.slice(0..9)
      |> Date.from_iso8601!()}
    </div>
    """
  end
end
