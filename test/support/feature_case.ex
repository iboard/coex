defmodule CoexWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use CoexWeb, :verified_routes

      import CoexWeb.FeatureCase

      import PhoenixTest
    end
  end

  setup _tags do
    #  We don't use ECTO yet.
    #  pid = Ecto.Adapters.SQL.Sandbox.start_owner!(MyApp.Repo, shared: not tags[:async])
    #  on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
