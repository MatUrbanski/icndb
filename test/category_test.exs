defmodule CategoryTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Icndb.Category

  setup_all do
    HTTPoison.start
  end

  describe "all/1" do
    test "returns all categories from ICNDB API" do
      categories = [
        %Icndb.Category{
          name: "explicit"
        },
        %Icndb.Category{
          name: "nerdy"
        }
      ]

      use_cassette "all_categories" do
        assert Icndb.Category.all == categories
      end
    end
  end
end
