defmodule CoexWeb.PageController do
  use CoexWeb, :controller
  import CoexWeb.UserAuth, only: [fetch_current_user: 2]

  plug :fetch_current_user

  def home(conn, _params) do
    # render(conn, :home, layout: false)
    conn
    |> redirect(to: ~p"/l")
  end
end
