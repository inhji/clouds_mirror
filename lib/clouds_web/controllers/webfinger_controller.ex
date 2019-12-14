defmodule CloudsWeb.WebfingerController do
  use CloudsWeb, :controller
  alias Clouds.Users
  alias Clouds.Users.User

  plug :accepts, ["json"]

  def index(conn, %{"resource" => resource}) do
    {:ok, regex} = Regex.compile("acct:\\w+@#{Clouds.domain()}")

    with true <- Regex.match?(regex, resource),
         username <- extract_username(resource),
         true <- Users.user_exists?(username),
         user <- Users.get_user() do
      conn
      |> json(%{
        "subject" => resource,
        "links" => [
          %{
            "rel" => "self",
            "type" => "application/activity+json",
            "href" => User.actor_url()
          }
        ]
      })
    else
      _ -> bad_request(conn)
    end
  end

  def index(conn, _params) do
    bad_request(conn)
  end

  defp bad_request(conn) do
    conn
    |> put_status(400)
    |> json(%{
      error: "Bad Request"
    })
  end

  defp extract_username(resource) do
    resource
    |> String.replace("acct:", "")
    |> String.replace("@#{Clouds.domain()}", "")
  end
end
