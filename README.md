# Scrivener

[![Build Status](https://github.com/drewolson/scrivener/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/drewolson/scrivener/actions/workflows/test.yml)
[![Module Version](https://img.shields.io/hexpm/v/scrivener.svg)](https://hex.pm/packages/scrivener)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/scrivener/)
[![Total Download](https://img.shields.io/hexpm/dt/scrivener.svg)](https://hex.pm/packages/scrivener)
[![License](https://img.shields.io/hexpm/l/scrivener.svg)](https://github.com/drewolson/scrivener/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/drewolson/scrivener.svg)](https://github.com/drewolson/scrivener/commits/master)

**Note**: You're probably looking for [Scrivener.Ecto](https://github.com/drewolson/scrivener_ecto). Have a look there first.

Scrivener is a pagination library for the Elixir ecosystem. You most likely won't use Scrivener directly, instead using a library that implements Scrivener's `Paginater` protocol for the type of data you're trying to paginate.

The primary use for Scrivener is the pagination of Ecto queries. For more information, see [Scrivener.Ecto](https://github.com/drewolson/scrivener_ecto).

## Low Maintenance Warning

This library is in low maintenance mode, which means the author is currently
only responding to pull requests and breaking issues.

## Related Libraries

* [Scrivener.Ecto](https://github.com/drewolson/scrivener_ecto) paginate your Ecto queries with Scrivener
* [Scrivener.HTML](https://github.com/mgwidmann/scrivener_html) generates HTML output using Bootstrap or other frameworks
* [Scrivener.Headers](https://github.com/doomspork/scrivener_headers) adds response headers for API pagination
* [Scrivener.List](https://github.com/stephenmoloney/scrivener_list) allows pagination of a list

## Installation

Add `:scrivener` to your `mix.exs` `applications` and `dependencies`.

```elixir
def application do
  [
    applications: [:scrivener]
  ]
end
```

```elixir
def deps do
  [
    {:scrivener, "~> 2.0"}
  ]
end
```

## Contributing

You can run the tests with the following command:

```elixir
mix test
```

## Copyright and License

Copyright (c) 2015 Drew Olson

Released under the MIT License, which can be found in the repository in [`LICENSE`](https://github.com/drewolson/scrivener/blob/master/LICENSE).
