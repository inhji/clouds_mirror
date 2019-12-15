defmodule CloudsWeb.ActivityController do
  use CloudsWeb, :controller
  alias Clouds.Activities

  def show(conn, %{"id" => activity_id}) do
    activity = Activities.get_activity(activity_id)

    render(conn, "show.json", activity: activity)
  end
end
