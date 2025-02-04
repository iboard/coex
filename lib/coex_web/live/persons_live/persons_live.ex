defmodule CoexWeb.PersonsLive do
  use CoexWeb, :live_view

  use CoexWeb.Ticker

  @store_path "data/#{Mix.env()}/persons.data"

  def mount(_, _, socket) do
    if connected?(socket), do: tick(self(), :minutes), else: open_store()

    socket =
      socket
      |> stream(:persons, list_persons())
      |> assign(:form, nil)

    {:ok, socket}
  end

  def handle_params(_params, _, %{assigns: %{live_action: :index}} = socket) do
    socket =
      socket
      |> stream(:persons, list_persons())

    {:ok, socket}
    {:noreply, socket}
  end

  def handle_params(_params, _, %{assigns: %{live_action: :new}} = socket) do
    socket =
      socket
      |> assign(:form, to_form(%{"name" => "", "age" => ""}))

    {:noreply, socket}
  end

  def handle_event("create_person", params, socket) do
    socket =
      case create_person(params) do
        {:ok, person} ->
          socket
          |> handle_success(person)
          |> push_patch(to: ~p"/persons")

        {:error, errors} ->
          socket
          |> assign(:form, to_form(params, errors: errors))
      end

    {:noreply, socket}
  end

  # private implementation

  defp create_person(params)

  defp create_person(%{"name" => name, "age" => age}) when name != "" and age != "" do
    {:ok, {id, _person}} = Conion.Store.insert_new(:persons, %{name: name, age: age})
    Conion.Store.persist(:persons)
    {:ok, %{id: id, name: name, age: age}}
  end

  defp create_person(%{"name" => "", "age" => ""}) do
    {:error, errors_for([:name, :age])}
  end

  defp create_person(%{"name" => _, "age" => ""}) do
    {:error, errors_for([:age])}
  end

  defp create_person(%{"name" => "", "age" => _}) do
    {:error, errors_for([:name])}
  end

  defp errors_for(fields) do
    Enum.reduce(fields, Keyword.new(), fn field, errors ->
      case field do
        :name -> Keyword.put(errors, :name, {"can't be blank", []})
        :age -> Keyword.put(errors, :age, {"can't be blank", []})
        true -> errors
      end
    end)
  end

  defp handle_success(socket, person) do
    socket
    |> assign(:form, nil)
    |> stream_insert(:persons, person)
    |> put_flash(
      :info,
      gettext(
        "New person \"%{name}\" created successfully.",
        %{name: person.name}
      )
    )
  end

  defp list_persons() do
    Conion.Store.list(:persons)
    |> Enum.map(fn {id, person} -> Map.put(person, :id, id) end)
    |> Enum.sort_by(fn person -> person.age |> String.to_integer() end)
  end

  defp open_store() do
    Conion.Store.new_bucket(:persons, Conion.Store.Persistor.File, filename: @store_path)
  end
end
