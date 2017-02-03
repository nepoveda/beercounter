class MenuItem
  constructor: (name, price) ->
    @name  = name
    @price = price

class CustumerItem
  constructor: (name, price, count) ->
    @name = name
    @price = price
    @count = count


class Menu
  constructor: (items = {}) ->
    @items = items

  add: (name, item) ->
    @items[name] = item

  remove: (name) ->
    delete @items[name]

class Pub
  constructor: (name, menu) ->
    @name = name
    @menu = menu

module.exports = { Pub, Menu, MenuItem }
