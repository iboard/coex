defmodule PersonLiveTest do
  use CoexWeb.FeatureCase, async: true

  describe "Person Featre" do
    test "landing page has a link to the persons feature", %{conn: conn} do
      conn
      |> visit("/")
      |> click_link("Persons")
      |> assert_has("a[role=add_person]", text: "New Person")
    end

    test "create a new valid person", %{conn: conn} do
      conn
      |> visit("/persons")
      |> click_link("New Person")
      |> fill_in("Name", with: "Harald")
      |> fill_in("Age", with: 55)
      |> click_button("Create Person")
      |> assert_has("#flash-info", text: "New person \"Harald\" created successfully")
      |> assert_has("#persons", text: "Harald")
    end

    test "show error if name is blank", %{conn: conn} do
      conn
      |> visit("/persons")
      |> click_link("New Person")
      |> fill_in("Age", with: "34")
      |> click_button("Create Person")
      |> assert_has("p", text: "can't be blank")
    end

    test "show error if age is blank", %{conn: conn} do
      conn
      |> visit("/persons")
      |> click_link("New Person")
      |> fill_in("Name", with: "Harald")
      |> click_button("Create Person")
      |> assert_has("p", text: "can't be blank")
    end

    test "add two persons", %{conn: conn} do
      conn
      |> visit("/persons")
      # Add Harald
      |> click_link("New Person")
      |> fill_in("Name", with: "Harald")
      |> fill_in("Age", with: 55)
      |> click_button("Create Person")
      |> assert_has("#flash-info", text: "New person \"Harald\" created successfully")
      |> assert_has("#persons", text: "Harald")
      # Add Bobby
      |> click_link("New Person")
      |> fill_in("Name", with: "Bobby")
      |> fill_in("Age", with: 56)
      |> click_button("Create Person")
      |> assert_has("#flash-info", text: "New person \"Bobby\" created successfully")
      # Assert both persons are listed
      |> assert_has("#persons", text: "Bobby")
      |> assert_has("#persons", text: "Harald")
    end
  end
end
