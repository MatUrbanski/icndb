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

    test "random_joke is returned when argument is random_joke" do
      use_cassette "random_joke" do
        execute_main = fn ->
          main(["random_joke"])
        end

        assert capture_io(execute_main) =~
          "Chuck Norris hosting is 101% uptime guaranteed."
      end
    end
  end
end
