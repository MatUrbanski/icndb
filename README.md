# Icndb

[![Build Status](https://travis-ci.org/MatUrbanski/icndb.svg?branch=master)](https://travis-ci.org/MatUrbanski/icndb)

**API client for ICNDB API written in Elixir.**
**More details in documentation: https://hexdocs.pm/icndb/api-reference.html**

## Installation

The package can be installed as:

  1. Add `icndb` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:icndb, "~> 0.1.0"}]
    end
    ```

  2. Ensure `icndb` is started before your application:

    ```elixir
    def application do
      [applications: [:icndb]]
    end
    ```

