defmodule Blog.Articles do
  @moduledoc """
  The Articles context.
  """
  alias Blog.Articles.Post

  use NimblePublisher,
    build: Post,
    from: Application.app_dir(:blog, "priv/resources/articles/**/*.md"),
    html_converter: Blog.MarkdownConverter,
    as: :posts

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})


  def all_posts,do: @posts
  def all_active_posts, do: Enum.filter(all_posts(), &(&1.show == true)) 
  def all_tags, do: Enum.map(all_active_posts(), &(&1.tags)) |> Enum.uniq() 



  defmodule NotFoundError, do: defexception([:message, plug_status: 404])

  def get_post_by_id!(id) do
    Enum.find(all_posts(), &(&1.id == id)) ||
      raise NotFoundError, "post with id=#{id} not found"
  end

  def get_posts_by_tag!(tag) do
    case Enum.filter(all_posts(), &(tag in &1.tags)) do
      [] -> raise NotFoundError, "posts with tag=#{tag} not found"
      posts -> posts
    end
  end
end
