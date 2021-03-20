# Scrivener

[![Build
Status](https://github.com/drewolson/scrivener/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/drewolson/scrivener/actions/workflows/test.yml)

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

Add `scrivener` to your `mix.exs` `applications` and `dependencies`.

```elixir
def application do
  [applications: [:scrivener]]
end
```

```elixir
[{:scrivener, "~> 2.0"}]
```

## Contributing

You can run the tests with the following command:

```elixir
mix test
```
