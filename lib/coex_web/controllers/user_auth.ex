defmodule CoexWeb.UserAuth do
  import Plug.Conn

  @doc """
  Authenticates the user by looking into the session.
  """
  def fetch_current_user(conn, _opts) do
    assign(conn, :current_user, nil)
  end

  def on_mount(:current_user, _params, session, socket) do
    case session do
      %{"user_id" => _user_id} ->
        # {:cont, assign_new(socket, :current_user, fn -> Accounts.get_user(user_id) end)}
        {:halt, socket}

      %{} ->
        socket = %{socket | assigns: Map.put(socket.assigns, :current_user, nil)}
        {:cont, socket}
    end
  end
end
