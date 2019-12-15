defmodule CloudsWeb.ActivityView do
  use CloudsWeb, :view

  def render("show.json", %{activity: activity}) do
    Clouds.Activities.Activity.to_json(activity)
  end
end
