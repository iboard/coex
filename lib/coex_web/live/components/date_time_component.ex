defmodule DateTimeComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <div class="font-mono">
      {@now
      |> to_string()
      |> precision(@precision)}
    </div>
    """
  end

  defp precision(str, :seconds), do: String.slice(str, 0..18)
  defp precision(str, :minutes), do: String.slice(str, 0..15)
end
