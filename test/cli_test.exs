defmodule CLITest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import Icndb.CLI
  import ExUnit.CaptureIO

  doctest Icndb.CLI

  setup_all do
    HTTPoison.start
  end

  describe "main" do
    test "help instructions are returned when argument is -h" do
      execute_main = fn ->
        main(["-h"])
      end

      assert capture_io(execute_main) =~ "ICNDB API"
    end

    test "help instructions are returned when argument is --help" do
      execute_main = fn ->
        main(["--help"])
      end

      assert capture_io(execute_main) =~ "ICNDB API"
    end

    test "random_joke/0 is returned when argument is random_joke" do
      use_cassette "random_joke" do
        execute_main = fn ->
          main(["random_joke"])
        end

        assert capture_io(execute_main) =~
          "Chuck Norris hosting is 101% uptime guaranteed."
      end
    end

    test "random_joke/1 is returned when argument is random_joke 2" do
      use_cassette "multiple_random_joke" do
        execute_main = fn ->
          main(["random_jokes", 2])
        end

        assert capture_io(execute_main) =~
          "In a fight between Batman and Darth Vader, the winner would be Chuck Norris."
        assert capture_io(execute_main) =~
          "When an episode of Walker Texas Ranger was aired in France, the French surrendered to Chuck Norris just to be on the safe side."
      end
    end

    test "find/1 is returned when argument is find 1" do
      use_cassette "specific_joke" do
        execute_main = fn ->
          main(["find_joke", 1])
        end

        assert capture_io(execute_main) =~
          "Chuck Norris uses ribbed condoms inside out, so he gets the pleasure."
      end
    end

    test "jokes_count/0 is returned when argument is jokes_count" do
      use_cassette "jokes_count" do
        execute_main = fn ->
          main(["jokes_count"])
        end

        assert capture_io(execute_main) =~ "539"
      end
    end

    test "categories/0 is returned when argument is categories" do
      use_cassette "all_categories" do
        execute_main = fn ->
          main(["categories"])
        end

        assert capture_io(execute_main) =~ "explicit"
        assert capture_io(execute_main) =~ "nerdy"
      end
    end
  end
end
