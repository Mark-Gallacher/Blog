defmodule BlogWeb.CustomComponents do
  use Gettext, backend: BlogWeb.Gettext
  use BlogWeb, :html

  attr(:title, :string, required: true)
  attr(:image, :string, required: true)
  attr(:description, :string, required: true)
  attr(:link, :string, required: true)
  attr(:tags, :list, required: true)
  attr(:date, :string, required: true)
  attr(:class, :string, default: nil)

  def card(assigns) do
    ~H"""
    <.link navigate={~p"/post/#{@link}"}>
      <div class={["card bg-base-200 shadow-sm group", @class]}>
        <figure >
          <img
          src={~p"/images/2025/#{@link}/#{@image}"}
          alt="Album"
          class="object-scale-down"/>

        </figure>
        <div class="card-body text-left">

          <div class="flex flex-wrap items-center">  
            <h2 class="card-title">
              {@title} 
            </h2>

            <span class="text-xs text-end md:ml-auto">
              {Calendar.strftime(@date, "%d %b %Y")}
            </span>

          </div>  
          <p class="text-pretty text-sm justify-text ">
            {@description}
          </p>

          <.tagset tags={@tags} />

          <div class="card-actions justify-center items-end">
            <button class="btn btn-soft btn btn-info">
              <span class="group-hover:underline">
                Read More
              </span>
            </button>
          </div>
        </div>
      </div>
    </.link>
    """
  end

  attr(:label, :string)

  def tag(assigns) do
    ~H"""
    <span class="badge badge-soft badge-accent text-bold">
        {@label}
    </span>    
    """
  end

  attr(:tags, :list, default: [])
  attr(:class, :string, default: nil)

  def tagset(assigns) do
    ~H"""
    <div :if={@tags != []} class={["flex flex-wrap gap-2", @class]}>
      <%= for tag <- @tags do %>
        <.tag label={tag} />
        <% end %>
    </div> 
    """
  end

  attr(:current_path, :string, required: true)

  def topbar(assigns) do
    ~H"""
    <div class="place-items-center w-full py-3">
      <div class="navbar shadow-sm px-4 bg-transpareent">
        <div class="mx-auto flex w-full items-center px-4">
          <button class="btn btn-square btn-ghost">
            <a href ="/">
              <.avatar image="profile.jpg" />
            </a>
          </button>
          <div class="mx-auto rounded-btn bg-base-200 space-x-2 px-4 py-2 sm:block justify-center">

            <.link
              :for={%{label: label, to: to} <- list_main_pages()}
              navigate={to}
              class={["btn btn-sm hover:ring-info hover:ring-4", if(current_page?(@current_path, to), do: "btn-info btn-soft", else: "btn-ghost")]}>
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

  attr(:class, :string, default: nil)
  slot(:inner_block)

  def grid(assigns) do
    ~H"""
    <section class={["grid gap-5 md:grid-cols-2 lg:grid-cols-3", @class]}>
      {render_slot(@inner_block)}
    </section>
    """
  end

  defp list_main_pages() do
    [
      %{label: "Home", to: ~p"/"},
      %{label: "Blog", to: ~p"/post"},
      %{label: "About", to: ~p"/about"}
    ]
  end

  defp current_page?(current_path, route) do
    %{path: path} = URI.parse(current_path)

    if route == "/" do
      path == route
    else
      String.starts_with?(path, route)
    end
  end
end
