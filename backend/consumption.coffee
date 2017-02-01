_       = require('lodash')
express = require('express')
{ items, consumers, consumption } = require('./globals')

router = express.Router()

# GET /consumption             - returns all consumption
# GET /consumption?name=<name> - returns consumption by consumer name
router.get '/', (req, res) ->
  name = req.query.name

  if name?
    consumer = _.find(consumers, name: name)

    if consumer?
      cons = _.find(consumption, consumer_id: consumer.id)
      res.json(status: 'OK', consumption: cons)
    else
      res.status(404).json(status: 'Not found', message: "consumer with name '#{name}' not found")

  else
    res.json(status: 'OK', consumption: consumption)

# GET /consumption/:id - returns consumption by consumer id
router.get '/:id', (req, res) ->
  id = Number.parseInt(req.params.id)

  unless Number.isInteger(id)
    return res.status(400).json(status: 'Bad request', message: 'missing/non-integer id')

  cons = _.find(consumption, consumer_id: id)

  if cons?
    res.json(status: 'OK', consumption: cons)
  else
    res.status(404).json(status: 'Not found', message: "consumer with id #{id} not found")

# POST /consumption/:consumer_id/increment/:item_id - increments consumer's item consuption
router.post '/:consumer_id/increment/:item_id', (req, res) ->
  consumer_id = Number.parseInt(req.params.consumer_id)
  item_id     = Number.parseInt(req.params.item_id)

  unless Number.isInteger(consumer_id)
    return res.status(400).json(status: 'Bad request', message: 'missing/non-integer consumer_id')

  unless Number.isInteger(item_id)
    return res.status(400).json(status: 'Bad request', message: 'missing/non-integer item_id')

  consumer = _.find(consumers,   id: consumer_id)
  item     = _.find(items,       id: item_id)
  cons     = _.find(consumption, consumer_id: consumer_id)

  unless consumer?
    res.status(404).json(status: 'Not found', message: "consumer with id #{id} not found")

  unless item?
    res.status(404).json(status: 'Not found', message: "item with id #{id} not found")

  if cons?
    item_cons = _.find(cons.consumption, item_id: item_id)

    if item_cons?
      item_cons.count += 1
    else
      cons.consumption.push(item_id: item_id, count: 1)

    res.json(status: 'OK', consumption: cons)

  else
    cons = { consumer_id: consumer_id, consumption: { item_id: item_id, count: 1 } }

    consumption.push(cons)

    res.json(status: 'OK', consumption: cons)

# POST /consumption/:consumer_id/decrement/:item_id - decrements consumer's item consuption
router.post '/:consumer_id/decrement/:item_id', (req, res) ->
  consumer_id = Number.parseInt(req.params.consumer_id)
  item_id     = Number.parseInt(req.params.item_id)

  unless Number.isInteger(consumer_id)
    return res.status(400).json(status: 'Bad request', message: 'missing/non-integer consumer_id')

  unless Number.isInteger(item_id)
    return res.status(400).json(status: 'Bad request', message: 'missing/non-integer item_id')

  consumer = _.find(consumers,   id: consumer_id)
  item     = _.find(items,       id: item_id)
  cons     = _.find(consumption, consumer_id: consumer_id)

  unless consumer?
    res.status(404).json(status: 'Not found', message: "consumer with id #{id} not found")

  unless item?
    res.status(404).json(status: 'Not found', message: "item with id #{id} not found")

  if cons?
    item_cons = _.find(cons.consumption, item_id: item_id)

    if item_cons?
      if item_cons.count == 0
        return res.status(404).json(status: 'Bad request', message: "consumer's item consumption is already 0")

      item_cons.count -= 1

      res.json(status: 'OK', consumption: cons)

    else
      return res.status(404).json(status: 'Bad request', message: "consumer's item consumption is already 0")

  else
    return res.status(404).json(status: 'Bad request', message: "consumer's item consumption is already 0")

# DELETE /consumption/:id - deletes consumption by consumer id
router.delete '/:id', (req, res) ->
  id = Number.parseInt(req.params.id)

  unless Number.isInteger(id)
    return res.status(400).json(status: 'Bad request', message: 'missing/non-integer id')

  found = _.remove(consumption, (cons) -> cons.consumer_id == id)

  if found.length
    res.json(status: 'OK', consumption: found[0])
  else
    res.status(404).json(status: 'Not found', message: "consumer with id #{id} not found")

# DELETE /consumption?name=<name> - deletes consumption by consumer name
router.delete '/', (req, res) ->
  name = req.query.name

  unless name
    return res.status(400).json(status: 'Bad request', message: 'missing/empty name')

  consumer = _.find(consumers, name: name)

  if consumer?
    found = _.remove(consumption, (cons) -> cons.consumer_id == consumer.id)
    res.json(status: 'OK', consumption: found[0])
  else
    res.status(404).json(status: 'Not found', message: "consumer with name '#{name}' not found")

module.exports = { consumptionRouter: router }
