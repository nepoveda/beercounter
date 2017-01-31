express = require('express')
parser  = require('body-parser')
cors    = require('cors')
app     = express()

menu = { items: { 'test item': { price: 12.34 } } }

app.use(parser.json())
app.use(cors())

app.get '/menu', (req, res) ->
  res.json(menu)

app.post '/menu', (req, res) ->
  if !(req.body.name? and req.body.name.length)
    res.json(status: 'FAILED', message: 'missing name')
    return

  if !(req.body.price? and isFinite(req.body.price))
    res.json(status: 'FAILED', message: 'missing price')
    return

  menu['items'][req.body.name] = { price: parseFloat(req.body.price) }

  res.json(status: 'OK')

app.delete '/menu', (req, res) ->
  delete menu['items'][req.query.name]

  res.json(status: 'OK')

app.listen(3000)
