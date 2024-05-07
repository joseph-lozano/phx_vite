defmodule PhxViteWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use PhxViteWeb, :controller` and
  `use PhxViteWeb, :live_view`.
  """
  use PhxViteWeb, :html

  embed_templates "layouts/*"

  @compile {:inline, index_css: 0}
  if Application.compile_env(:phx_vite, :env) == :prod do
    @index_css :phx_vite
               |> :code.priv_dir()
               |> Path.join("static/.vite/manifest.json")
               |> File.read!()
               |> Jason.decode!()
               |> get_in(["index.html", "css"])
               |> hd()

    def index_css() do
      @index_css
    end
  else
    def index_css() do
      css =
        :phx_vite
        |> :code.priv_dir()
        |> Path.join("static/.vite/manifest.json")
        |> File.read!()
        |> Jason.decode!()
        |> get_in(["index.html", "css"])
        |> hd()

      "/#{css}"
    end
  end
end
