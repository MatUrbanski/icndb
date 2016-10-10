defmodule ResponseHandlerTest do
  use ExUnit.Case

  import Icndb.ResponseHandler

  doctest Icndb.ResponseHandler

  describe "handle_response" do
    test "returns map with joke attributes when status code is 200" do
      response = {:ok, %{status_code: 200, body: "{\"value\": {\"joke\": \"Funny joke.\"} }"}}
      joke = %{"joke" => "Funny joke."}

      assert handle_response(response) == joke
    end

    test "returns tuple with error message when status code is not 200" do
      response = {:error, %{status_code: 404, body: 'Error'}}
      error = {:error, "Something went wrong. Please try again."}

      assert handle_response(response) == error
    end
  end
end
