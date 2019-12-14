defmodule CloudsWeb.WebfingerControllerTest do
  use CloudsWeb.ConnCase

  @tag with_user: "inhji"
  test "GET /.well-known/webfinger?resource=acct:inhji@localhost:4002", %{conn: conn} do
    conn = get(conn, "/.well-known/webfinger?resource=acct:inhji@localhost:4002")
    json = json_response(conn, 200)
    assert json["subject"]
    assert json["links"]

    # json = json_response(conn, 400)
    # assert json["error"]
  end

  test "GET /.well-known/webfinger?resource=acct:foo@localhost:4002", %{conn: conn} do
    conn = get(conn, "/.well-known/webfinger?resource=acct:foo@localhost:4002")
    json = json_response(conn, 400)
    assert json["error"]
  end

  test "GET /.well-known/webfinger?lol=rofl", %{conn: conn} do
    conn = get(conn, "/.well-known/webfinger?lol=rofl")
    json = json_response(conn, 400)
    assert json["error"]
  end
end
