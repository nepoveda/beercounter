_             = require('lodash')
express       = require('express')
{ consumers } = require('./globals')

router = express.Router()

# GET /consumers - returns all consumers
# GET /consumers?name=<name> - returns consumer by name
router.get '/', (req, res) ->
  name = req.query.name

  if name?
    consumer = _.find(consumers, name: name)

    if consumer?
      res.json(status: 'OK', consumer: consumer)
    else
      res.status(404).json(status: 'Not found', message: "consumer with name #{name} not found")

  else
    res.json(status: 'OK', consumers: consumers)

# GET /consumers/:id - returns consumer by id
router.get '/:id', (req, res) ->
  id = Number.parseInt(req.params.id)

  unless Number.isInteger(id)
    return res.status(400).json(status: 'Bad request', message: 'missing/non-integer id')

  consumer = _.find(consumers, id: id)

  if consumer?
    res.json(status: 'OK', consumer: consumer)
  else
    res.status(404).json(status: 'Not found', message: "consumer with id #{id} not found")

# POST /consumers { name: 'name' } - creates consumer
router.post '/', (req, res) ->
  name = req.body.name

  unless name
    return res.status(400).json(status: 'Bad request', message: 'missing/empty name')

  if _.find(consumers, name: 'name')
    return res.status(400).json(status: 'Bad request', message: "consumer with name #{name} already exists")

  id       = _.maxBy(consumers, 'id').id + 1
  consumer = { id: id, name: name }

  consumers.push(consumer)

  res.json(status: 'OK', consumer: consumer)

# DELETE /consumers/:id - deletes consumer by id
router.delete '/:id', (req, res) ->
  id = Number.parseInt(req.params.id)

  unless Number.isInteger(id)
    return res.status(400).json(status: 'Bad request', message: 'missing/non-integer id')

  found = _.remove(consumers, (consumer) -> consumer.id == id)

  if found.length
    res.json(status: 'OK', consumer: found[0])
  else
    res.status(404).json(status: 'Not found', message: "consumer with id #{id} not found")

# DELETE /consumers?name=<name> - deletes consumer by name
router.delete '/', (req, res) ->
  name = req.query.name

  unless name
    return res.status(400).json(status: 'Bad request', message: 'missing/empty name')

  found = _.remove(consumers, (consumer) -> consumer.name == name)

  if found.length
    res.json(status: 'OK', consumer: found[0])
  else
    res.status(404).json(status: 'Not found', message: "consumer with name #{name} not found")

module.exports = { consumersRouter: router }
