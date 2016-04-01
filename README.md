# Scrivener

[![Build Status](https://travis-ci.org/drewolson/scrivener.svg)](https://travis-ci.org/drewolson/scrivener) [![Hex Version](http://img.shields.io/hexpm/v/scrivener.svg?style=flat)](https://hex.pm/packages/scrivener) [![Hex docs](http://img.shields.io/badge/hex.pm-docs-green.svg?style=flat)](https://hexdocs.pm/scrivener)

Scrivener is a pagnation library for the Elixir ecosystem. You most likely won't use Scrivener directly, instead using a library that implements Scrivener's `Paginater` protocol for the object you're trying to paginate.

The primary use for Scrivener is the pagination of Ecto queries. For more information, see [Scrivener.Ecto](https://github.com/drewolson/scrivener_ecto).

## Related Libraries

* [Scrivener.HTML](https://github.com/mgwidmann/scrivener_html) generates HTML output using Bootstrap or other frameworks
* [Scrivener.Headers](https://github.com/doomspork/scrivener_headers) adds response headers for API pagination
* [Scrivener.List](https://github.com/stephenmoloney/scrivener_list) allows pagination of a list

## Installation

Add `scrivener` to your `mix.exs` dependencies.

```elixir
defp deps do
  [{:scrivener, "~> 2.0"}]
end
```

## Contributing

You can run the tests with the following command:

```elixir
mix test
```
