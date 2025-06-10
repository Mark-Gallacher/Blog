defmodule BlogWeb.PageControllerTest do
  use BlogWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Bioinformatician and Software Developer."
    assert html_response(conn, 200) =~ "Recent Posts"
    assert html_response(conn, 200) =~ "View All Posts"
  end
end
