defmodule MyApp.Router.Helpers do

  def post_path(conn, :index, params), do: "/posts#{query_params(params)}"
  def post_comment_path(conn, :index, post_id, params), do: "/posts/#{post_id}#{query_params(params)}"

  defp query_params(params) do
    Enum.reduce params, "?", fn {k, v}, s ->
      "#{s}#{if(s == "?", do: "", else: "&")}#{k}=#{v}"
    end
  end
  
end
