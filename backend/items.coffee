_         = require('lodash')
express   = require('express')
{ items } = require('./globals')

router = express.Router()

# GET /items - returns all items
# GET /items?name=<name> - returns item by name
router.get '/', (req, res) ->
  name = req.query.name

  if name?
    item = _.find(items, name: name)

    if item?
      res.json(status: 'OK', item: item)
    else
      res.status(404).json(status: 'Not found', message: "item with name #{name} not found")

  else
    res.json(status: 'OK', items: items)

# GET /items/:id - returns items item by id
router.get '/:id', (req, res) ->
  id = Number.parseInt(req.params.id)

  unless Number.isInteger(id)
    return res.status(400).json(status: 'Bad request', message: 'missing/non-integer id')

  item = _.find(items, id: id)

  if item?
    res.json(status: 'OK', item: item)
  else
    res.status(404).json(status: 'Not found', message: "item with id #{id} not found")

# POST /items { name: 'name', price: 12.34 } - creates item
router.post '/', (req, res) ->
  name  = req.body.name
  price = Number.parseFloat(req.body.price)

  unless name
    return res.status(400).json(status: 'Bad request', message: 'missing/empty name')

  unless Number.isFinite(price)
    return res.status(400).json(status: 'Bad request', message: 'missing/non-float price')

  if _.find(items, name: 'name')
    return res.status(400).json(status: 'Bad request', message: "item with name #{name} already exists")

  id   = _.maxBy(items, 'id').id + 1
  item = { id: id, name: name, price: price }

  items.push(item)

  res.json(status: 'OK', item: item)

# DELETE /items/:id - deletes item by id
router.delete '/:id', (req, res) ->
  id = Number.parseInt(req.params.id)

  unless Number.isInteger(id)
    return res.status(400).json(status: 'Bad request', message: 'missing/non-integer id')

  found = _.remove(items, (item) -> item.id == id)

  if found.length
    res.json(status: 'OK', item: found[0])
  else
    res.status(404).json(status: 'Not found', message: "item with id #{id} not found")

# DELETE /items?name=<name> - deletes item by name
router.delete '/', (req, res) ->
  name = req.query.name

  unless name
    return res.status(400).json(status: 'Bad request', message: 'missing/empty name')

  found = _.remove(items, (item) -> item.name == name)

  if found.length
    res.json(status: 'OK', item: found[0])
  else
    res.status(404).json(status: 'Not found', message: "item with name #{name} not found")

module.exports = { itemsRouter: router }
