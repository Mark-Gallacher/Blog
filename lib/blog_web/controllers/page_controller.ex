defmodule BlogWeb.PageController do
  use BlogWeb, :controller
  import BlogWeb.Utils

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    data =  %{ 
      all_posts: Blog.Articles.all_active_posts()
    } 
    |> get_current_path(conn)
    
    render(conn, :home, data)
  end
end
