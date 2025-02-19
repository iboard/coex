defmodule LandingLiveTest do
  use CoexWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "not authenticated" do
    test "landing page", %{conn: conn} do
      assert {:error, {:redirect, %{to: landing_path}}} = live(conn, "/")

      {:ok, lv, html} = live(conn, landing_path)
      assert html =~ "A demo and poc"

      refute element(lv, "#connection-error") |> has_element?()
    end

    test "unauthenticated menu", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/l")

      assert element(lv, "#features") |> has_element?()
    end
  end
end
