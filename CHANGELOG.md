# Changelog

## 2.7.2 - 2021-03-22

* Fix ex_doc dependency

## 2.7.1 - 2021-03-20

* Improve type specs

## 2.7.0 - 2019-03-01

* Add `scrivener_defaults` function

## 2.6.0 - 2019-02-08

* Implement `Collectable` for `Scrivener.Page`

## 2.5.0 - 2018-01-19

* Implement `slice` for `Scrivener.Page`

## 2.4.0 - 2017-10-27

* Allow arbitrary `options` to be passed during the `paginate` call

## 2.3.0 - 2017-03-27

* Allow specifying `caller`

## 2.2.1 - 2017-01-07

* Remove Elixir 1.4.0 warnings

## 2.2.0 - 2017-01-01

* Add arbitrary `options` to `Scrivener.Config`

## 2.1.1 - 2016-08-20

* Handle negative values for `page` and `page_size` appropriately

## 2.1.0 - 2016-08-14

* Allow `nil` to be passed as options to `paginate` function

## 2.0.0 - 2016-06-21

* Introduce `Scrivener.Paginater` protocol
* Extract `Scrivener.Ecto`

## 1.2.2 - 2016-11-22

* Gracefully handle no result when counting records

## 1.2.1 - 2016-05-29

* Support Ecto `~> 1.1`

## 1.2.0 - 2016-05-29

* Implement Enumerable protocol for `Scrivener.Page`
* Fix Ecto `1.0.x` compatibility bug

## 1.1.4 - 2016-04-17

* Correctly paginate unconstrained queries

## 1.1.3 - 2016-04-09

* Correctly handle nested joins

## 1.1.2 - 2016-02-13

* Correctly handle join tables when counting entries

## 1.1.1 - 2015-12-15

* Make `postgrex` dependency version less strict

## 1.1.0 - 2015-10-29

* Allow configuring `max_page_size`

## 1.0.0 - 2015-08-25

* Initial release
