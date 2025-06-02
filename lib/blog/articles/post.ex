defmodule Blog.Articles.Post do
  @enforce_keys [:id, :title, :date, :description, :image, :body, :tags, :show]
  defstruct [:id, :title, :date, :description, :image, :body, :tags, :show]

  @doc false
  def build(filename, attrs, body) do
    [year, day_month_id] =
      filename
      |> Path.rootname()
      |> Path.split()
      |> Enum.take(-2)

    [day, month, id] = String.split(day_month_id, "-", parts: 3)

    date = Date.from_iso8601!("#{year}-#{month}-#{day}")

    struct!(__MODULE__, [id: id, date: date, body: body] ++ Map.to_list(attrs))
  end
end
