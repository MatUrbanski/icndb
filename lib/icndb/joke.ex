defmodule Icndb.Joke do
  @moduledoc """
  Joke is a module responsible for fetching jokes from ICNB API.`
  """

  defstruct id: "", joke: "", categories: []

  use ExConstructor

  import Icndb.ResponseHandler

  alias Icndb.Joke

  @doc """
  Fetches specific joke from ICNDB API.

  ## Example

    `iex> Icndb.Joke.find(77)`

    `
    %Icndb.Joke{categories: [], id: 77,
     joke: "Chuck Norris can divide by zero."}
    `
  """

  def find(id) do
    "#{base_url}/#{id}"
    |> HTTPoison.get
    |> handle_response
    |> create_struct
  end

  @doc """
  Fetch random joke from ICNDB API.

  ## Example

    `iex> Icndb.Joke.random`

    `
    %Icndb.Joke{categories: [], id: 77,
     joke: "Chuck Norris can divide by zero."}
    `
  """

  def random do
    "#{base_url}/random"
    |> HTTPoison.get
    |> handle_response
    |> create_struct
  end

  @doc """
  Fetch specified count of random jokes form ICNDB API.

  ## Example

    `iex> Icndb.Joke.random(1)`

    `
    [%Icndb.Joke{categories: [], id: 77,
     joke: "Chuck Norris can divide by zero."}]
    `
  """

  def random(count \\ 1) do
    "#{base_url}/random/#{count}"
    |> HTTPoison.get
    |> handle_response
    |> create_array
  end

  @doc """
  Fetch jokes count from ICNDB API.

  ## Example

    `iex> Icndb.Joke.count`

    `539`
  """

  def count do
    "#{base_url}/count"
    |> HTTPoison.get
    |> handle_response
  end

  defp create_struct(joke) do
    Joke.new(joke)
  end

  defp create_array(jokes) do
    Enum.map(jokes, fn(joke) -> create_struct(joke) end)
  end

  defp base_url do
    "#{Application.get_env(:icndb, :api_url)}/jokes"
  end
end
