defmodule Web.HelioClientPageControllerTest do
  use Web.ConnCase

  alias Db.Clients

  describe "renders Helio page" do
    setup [:create_clients]

    test "renders default page with no useragent defined", %{conn: conn} do
      conn = get conn, "/"
      assert html_response(conn, 200) =~ "Built with ❤ in a garage in Izhevsk, Russia"
      assert html_response(conn, 200) =~ "<span class=\"button-title-text\">For Windows"
    end

    test "renders default page with Linux useragent", %{conn: conn} do
      conn = get useragent(conn, "Mozilla/5.0 (X11, Linux x86_64)"), "/"
      assert html_response(conn, 200) =~ "<span class=\"button-title-text\">For Linux"
      assert html_response(conn, 200) =~ "269.3 KB"
    end

    test "renders default page with Android useragent", %{conn: conn} do
      conn = get useragent(conn, "Mozilla/5.0 (Linux; Android 4.0.4)"), "/"
      assert html_response(conn, 200) =~ "<span class=\"button-title-text\">For Android"
    end

    test "renders download link for iOS even though only dev build is available", %{conn: conn} do
      conn = get useragent(conn, "Mozilla/5.0 (iPad; CPU OS 9_3_5 like Mac OS X)"), "/"
      assert html_response(conn, 200) =~ "<span class=\"button-title-text\">For iOS"
    end
  end

  defp create_clients(_) do
    Clients.update_versions([
      %{app_name: "helio", link: "1", platform_type: "Linux", build_type: "installer", branch: "stable", architecture: "all", version: "2.0", file_size: 275_808},
      %{app_name: "helio", link: "1", platform_type: "Windows", build_type: "installer", branch: "stable", architecture: "all", version: "2.0"},
      %{app_name: "helio", link: "1", platform_type: "macOS", build_type: "installer", branch: "stable", architecture: "all", version: "2.0"},
      %{app_name: "helio", link: "1", platform_type: "iOS", build_type: "TestFlight", branch: "develop", architecture: "all", version: "develop"},
      %{app_name: "helio", link: "1", platform_type: "Android", build_type: "installer", branch: "stable", architecture: "all", version: "2.0"}
    ])
    :ok
  end

  defp useragent(conn, agent) do
    conn
      |> recycle
      |> put_req_header("user-agent", agent)
  end
end
