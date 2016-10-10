defmodule Icndb.CLI do
  alias Icndb.Joke

  @moduledoc """
  CLI module is responsible for handling input from console.
  """

  @doc """
  Parse arguments that are passed from console and call valid process method.

  ## Example

    `iex> Icndb.CLI.main(["random_joke"])`

    `Chuck Norris can divide by zero.`

    `:ok`
  """

  def main(args) do
    args
    |> parse_args
    |> process
  end

  defp parse_args(args) do
    parse = OptionParser.parse(args, switches: [help: :boolean],
                                     aliases:  [h: :help])

    case parse do
       {[help: true], _, _}            -> :help
       {_, ["random_joke"], _}         -> :random_joke
       {_, ["random_jokes", count], _} -> {:random_jokes, count}
       {_, ["find_joke", id], _}       -> {:find_joke, id}
       {_, ["jokes_count"], _}         -> :jokes_count
    end
  end

  defp process(:help) do
    IO.puts """
    ICNDB API
    - - - - -

    ### Find random joke
    icndb random_joke
    """
  end

  defp process(:random_joke) do
    Joke.random.joke
    |> IO.puts
  end

  defp process({:random_jokes, count}) do
    Joke.random(count)
    |> Enum.each(fn(joke) -> IO.puts joke.joke end)
  end

  defp process({:find_joke, id}) do
    Joke.find(id).joke
    |> IO.puts
  end

  defp process(:jokes_count) do
    Joke.count
    |> IO.puts
  end
end
