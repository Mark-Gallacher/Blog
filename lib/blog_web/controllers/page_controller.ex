defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, all_posts: Blog.Articles.all_active_posts())
  end
end
