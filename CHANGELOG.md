# Changelog

## 2.5.0

* Implement `slice` for `Scrivener.Page`

## 2.4.0

* Allow arbitrary `options` to be passed during the `paginate` call

## 2.3.0

* Allow specifying `caller`

## 2.2.1

* Remove Elixir 1.4.0 warnings

## 2.2.0

* Add arbitrary `options` to `Scrivener.Config`

## 2.1.1

* Handle negative values for `page` and `page_size` appropriately

## 2.1.0

* Allow `nil` to be passed as options to `paginate` function

## 2.0.0

* Introduce `Scrivener.Paginater` protocol
* Extract `Scrivener.Ecto`

## 1.2.2

* Gracefully handle no result when counting records

## 1.2.1

* Support Ecto `~> 1.1`

## 1.2.0

* Implement Enumerable protocol for `Scrivener.Page`
* Fix Ecto `1.0.x` compatiblity bug

## 1.1.4

* Correctly paginate unconstrained queries

## 1.1.3

* Correctly handle nested joins

## 1.1.2

* Correctly handle join tables when counting entries

## 1.1.1

* Make `postgrex` dependency version less strict

## 1.1.0

* Allow configuring `max_page_size`

## 1.0.0

* Initial release
