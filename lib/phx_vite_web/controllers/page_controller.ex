defmodule PhxViteWeb.PageController do
  use PhxViteWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end

  if Mix.env() == :prod do
    @html :phx_vite
          |> :code.priv_dir()
          |> Path.join("/static/index.html")
          |> File.read!()

    def app(conn, _params) do
      html(conn, @html)
    end
  else
    def app(conn, _params) do
      html(conn, """
      <p style="font-size: 2rem">In dev mode use the Vite server at <a href="http://localhost:5173/app">http://localhost:5173/app</a></p>
      """)
    end
  end
end
