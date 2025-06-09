defmodule Blog.MarkdownConverter do
  @moduledoc """
  Converts markdown to HTML
  """

  def convert(_path, body, _attr, _opts) do
    MDEx.parse_document!(body)
    |> MDEx.to_html!(
      extension: [header_ids: ""],
      parse: [smart: true],
      render: [figure_with_caption: true]
    )
  end
end
