defmodule BlogWeb.Utils do

  def get_current_path(conn) do

    %{ current_path: conn.request_path }

  end

  def get_current_path(map, conn) do

    Map.put(map, :current_path, conn.request_path)

  end
end
