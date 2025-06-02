defmodule BlogWeb.PostController do
  use BlogWeb, :controller
  import BlogWeb.Utils
  alias Blog.Articles

  def index(conn, _params) do
    data = %{ 
      posts: Articles.all_posts(),
    }
    |> get_current_path(conn) 
    
    render(conn, "index.html", data)
  end

  def show(conn, %{"id" => id}) do
    data = %{ 
      post: Articles.get_post_by_id!(id)
    }
    |> get_current_path(conn) 

    render(conn, "show.html", data)
  end
end
