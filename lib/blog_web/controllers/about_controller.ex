defmodule BlogWeb.AboutController do
  use BlogWeb, :controller
  import BlogWeb.Utils

  def about(conn, _params) do
    
    render(conn, :about, get_current_path(conn))
  end 
end
