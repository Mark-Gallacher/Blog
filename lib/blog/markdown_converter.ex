defmodule Blog.MarkdownConverter do
  @moduledoc """
  Converts markdown to HTML
  """

  def convert(_path, body, _attr, _opts) do
    MDEx.to_html!(body, extension: [header_ids: ""], parse: [smart: true])
  end
end
