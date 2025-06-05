defmodule BlogWeb.PostHTML do
  use BlogWeb, :html
  import BlogWeb.CustomComponents

  embed_templates("post_html/*")
end
