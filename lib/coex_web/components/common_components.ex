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

  @doc """
  Display the current date

  ## Examples

      <.current_date_time />

  """

  attr :id, :string, required: true
  attr :now, :any, default: nil
  attr :precision, :atom, default: :seconds

  def current_date_time(assigns) do
    ~H"""
    <.live_component module={DateTimeComponent} id={@id} now={@now} precision={@precision} />
    """
  end

  @doc """
  A menu box to display a title and a list of 
  menu items.

  ## Example

    <.menu_box id="some" 
       title={gettext "an optional title"}
       class="overwrite default class here"
       list_class="overwrite default list class here" 
       items={[{"label", "target"}, ...]}
       subtitle_class="overwrite the class for the subtitle"
    >
      Text as subtitle goes here
    <./menu_box>
  """

  attr :id, :string, required: true
  attr :class, :string, default: "p-4 my-4 w-fit border rounded-md bg-blue-100 shadow-sm"
  attr :list_class, :string, default: "list-inside list-disc"
  attr :subtitle_class, :string, default: "-mt-2 mb-2"
  attr :title, :string, required: false
  attr :items, :list, default: []
  slot :inner_block, required: false

  def menu_box(assigns) do
    ~H"""
    <div id={@id} class={@class}>
      <h2 :if={@title} class="text-lg font-semibold mb-0 pb-0">{@title}</h2>
      <div class={@subtitle_class}>{render_slot(@inner_block)}</div>
      <ul class={@list_class}>
        <li :for={{label, href} <- @items}><.link navigate={href} title={label}>{label}</.link></li>
      </ul>
    </div>
    """
  end
end
