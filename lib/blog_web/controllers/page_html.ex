defmodule BlogWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use BlogWeb, :html
  import BlogWeb.CustomComponents


  embed_templates "page_html/*"
end
