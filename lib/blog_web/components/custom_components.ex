defmodule BlogWeb.CustomComponents do
  use Gettext, backend: BlogWeb.Gettext
  use BlogWeb, :html

  attr(:title, :string, required: true)
  attr(:image, :string, required: true)
  attr(:description, :string, required: true)
  attr(:link, :string, required: true)

  def card(assigns) do
    ~H"""
    <div class="card bg-base-100 shadow-sm">
      <figure>
        <img
          src={~p"/images/2025/#{@image}"}
          alt="Album" />
      </figure>
      <div class="card-body text-left">
        <h2 class="card-title">
          {@title} This is a longer title!
        </h2>
        <p>
          {@description} this is just to make the description much longer, like it would be nice if we can see how it hanldes a bigger paragraph
        </p>
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


 attr(:current_path, :string, required: true)

  def topbar(assigns) do
    ~H"""
    <div class="place-items-center">
      <div class="navbar bg-base-100 shadow-sm border max-w-5xl px-4 ">
        <div class="mx-auto flex w-full items-center justify-between px-4">
          <button class="btn btn-square btn-ghost">
            <a href ="/">
              <.avatar image="profile.jpg" />
            </a>
          </button>
        <div class="rounded-btn bg-base-300 hidden space-x-2 px-4 py-2 sm:block">
          <.link
            :for={%{label: label, to: to} <- list_main_pages()}
            navigate={to}
            class={["btn btn-sm", if(current_page?(@current_path, to), do: "btn-primary", else: "btn-ghost")]}
          >
            {label}
          </.link>
        </div>
        </div>
      </div>
    </div>
    """
  end

  attr(:image, :string, required: true)

  def avatar(assigns) do
    ~H"""
    <.link navigate={~p"/"} class="avator cursor-pointer">
      <div class="w-14">
        <img src={~p"/images/#{@image}"} alt="Picture of Mark" class="rounded-full"/>
      </div>
    </.link>
    """
  end

  defp list_main_pages() do
    [
      %{label: "Home", to: ~p"/"},
      %{label: "About", to: ~p"/about"},
      %{label: "Blog", to: ~p"/post"},
    ]
  end

  defp current_page?(current_path, route) do
    %{ path: path } = URI.parse(current_path)

    if route == "/" do
      path == route
    else
      String.starts_with?(path, route)
    end
  end
end
