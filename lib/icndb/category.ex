defmodule Icndb.Category do
  @moduledoc """
  Category is a module responsible for fetching cateogories from ICNB API.`
  """

  defstruct name: ""

  use ExConstructor

  import Icndb.ResponseHandler

  alias Icndb.Category

  @doc """
  Fetches categories from ICNDB API.

  ## Example

    `iex> Icndb.Category.all`

    `[%Icndb.Category{name: "explicit"}, %Icndb.Category{name: "nerdy"}]`
  """

  def all do
    "#{Application.get_env(:icndb, :api_url)}/categories"
    |> HTTPoison.get
    |> handle_response
    |> create_array
  end

  defp create_struct(category) do
    Category.new(name: category)
  end

  defp create_array(categories) do
    Enum.map(categories, fn(category) -> create_struct(category) end)
  end
end
