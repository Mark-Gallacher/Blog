defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  alias Blog.Articles

  def index(conn, _params) do
    render(conn, "index.html", posts: Articles.all_posts())
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", post: Articles.get_post_by_id!(id))
  end
end
