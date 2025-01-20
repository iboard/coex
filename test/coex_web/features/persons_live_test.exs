defmodule PersonLiveTest do
  use CoexWeb.FeatureCase, async: true

  describe "e2e" do
    test "landing page has a link to the persons feature", %{conn: conn} do
      conn
      |> visit("/")
      |> click_link("Persons")
      |> assert_has("a[role=add_person]", text: "New Person")
    end
  end
end
