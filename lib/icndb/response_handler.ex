defmodule Icndb.ResponseHandler do
  alias Poison.Parser

  @moduledoc """
  ResponseHandler module is responsible for handling responses from ICNDB API.
  """

  @doc """
  Returns joke attributes when status_code is 200.

  ## Example

    `iex> response = {:ok, %{status_code: 200, body: "{\"value\": {\"joke\": \"Funny joke.\"} }"}}

    `iex> response |> Icndb.ResponseHandler.handle_response`

    `%{"joke" => "Funny joke."}`


  Returns `{:error, "Something went wrong. Please try again."}`
  when status_code is not 200.

  ## Example

    `iex> response = {:error, %{status_code: 500, body: "\"Error.\""}}`

    `iex> response |> Icndb.ResponseHandler.handle_response`

    `{:error, "Something went wrong. Please try again."}`
  """

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    map = {:ok, Parser.parse!(body)}
    {:ok, body} = map

    body |> get_in(["value"])
  end

  def handle_response({_, %{status_code: _, body: _}}) do
    {:error, "Something went wrong. Please try again."}
  end
end
