defmodule Blog.Articles.Post do
  @enforce_keys [:id, :title, :date, :description, :image, :body, :tags, :show]
  defstruct [:id, :title, :date, :description, :image, :body, :tags, :show]

  @doc ~s"""
  Ensure tags are in standard format

  Converts "machine-learning" => "Machine Learning"
  """
  def parse_tags(attrs) when is_map(attrs) do
    {tags, attrs} = Map.pop(attrs, :tags)

    tags = tags
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.map(fn list ->
      list
      |> Enum.map(&String.capitalize(&1))
      |> Enum.join(" ")
    end)

    Map.merge(%{tags: tags}, attrs)
  end

  @doc false
  def build(filename, attrs, body) do
    [year, day_month_id] =
      filename
      |> Path.rootname()
      |> Path.split()
      |> Enum.take(-2)

    [day, month, id] = String.split(day_month_id, "-", parts: 3)

    date = Date.from_iso8601!("#{year}-#{month}-#{day}")

    attrs = attrs 
    |> parse_tags()

    struct!(__MODULE__, [id: id, date: date, body: body] ++ Map.to_list(attrs))
  end
end
