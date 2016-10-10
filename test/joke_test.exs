defmodule JokeTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Icndb.Joke

  setup_all do
    HTTPoison.start
  end

  describe "random/0" do
    test "returns random joke" do
      joke = %Icndb.Joke{categories: ["nerdy"],
                         id: 498,
                         joke: "Chuck Norris hosting is 101% uptime guaranteed."}

      use_cassette "random_joke" do
        assert Icndb.Joke.random == joke
      end
    end
  end

  describe "random/1" do
    test "returns specified count of random jokes form ICNDB API" do
      jokes = [
        %Icndb.Joke{
          categories: [],
          id: 240,
          joke: "In a fight between Batman and Darth Vader, the winner would be Chuck Norris."
        },
        %Icndb.Joke{
          categories: [],
          id: 82,
          joke: "When an episode of Walker Texas Ranger was aired in France, the French surrendered to Chuck Norris just to be on the safe side."
        }
      ]

      use_cassette "multiple_random_joke" do
        assert Icndb.Joke.random(2) == jokes
      end
    end
  end

  describe "find/0" do
    test "returns specific joke from ICNDB API" do
      joke = %Icndb.Joke{categories: ["explicit"],
                         id: 1,
                         joke: "Chuck Norris uses ribbed condoms inside out, so he gets the pleasure."}

      use_cassette "specific_joke" do
        assert Icndb.Joke.find(1) == joke
      end
    end
  end

  describe "count/0" do
    test "returns jokes count from ICNDB API." do
      use_cassette "jokes_count" do
        assert Icndb.Joke.count == 539
      end
    end
  end
end
