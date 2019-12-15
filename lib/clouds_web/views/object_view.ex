defmodule CloudsWeb.ObjectView do
  use CloudsWeb, :view

  def render("show.json", %{object: object}) do
    Clouds.Objects.Object.to_json(object)
  end
end
