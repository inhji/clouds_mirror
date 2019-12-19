defmodule Clouds.Discovery do
  def discover_inbox(url) do
    with {:ok, %HTTPoison.Response{body: body, status_code: 200}} <-
           HTTPoison.get(url, [Accept: "application/json"], follow_redirect: true),
         {:ok, json} <- Jason.decode(body) do
      IO.inspect(json)
      {:ok, json["inbox"]}
    else
      e -> IO.inspect(e)
    end
  end

  def discover_actor(url) do
    with {:ok, %HTTPoison.Response{body: body, status_code: 200}} <-
           HTTPoison.get(url, [Accept: "application/json"], follow_redirect: true),
         {:ok, json} <- Jason.decode(body) do
      IO.inspect(json)

      {:ok, json["attributedTo"]}
    else
      e ->
        IO.inspect(e)
        e
    end
  end
end
