defmodule CoexWeb.PageControllerTest do
  use CoexWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "demo and poc"
  end
end
