defmodule BlogWeb.CustomComponents do
  use Gettext, backend: BlogWeb.Gettext
  use BlogWeb, :html
  
  attr :title, :string, required: true
  attr :image, :string, required: true
  attr :description, :string, required: true
  attr :link, :string, required: true

  def card(assigns) do
    ~H"""
<div class="card bg-base-100 shadow-sm">
  <figure>
    <img
      src={~p"/images/2025/#{@image}"}
      alt="Album" />
  </figure>
  <div class="card-body text-left">
    <h2 class="card-title">{@title} This is a longer title!</h2>
    <p>{@description} this is just to make the description much longer, like it would be nice if we can see how it hanldes a bigger paragraph</p>
    <div class="card-actions justify-center items-center">
      <button class="btn btn-soft btn-wide btn-secondary">
    <.link navigate={~p"/post/#{@link}"}>
        Read
    </.link>
      </button>
    </div>
  </div>
</div>
"""
  end
end
