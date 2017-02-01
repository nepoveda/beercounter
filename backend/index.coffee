express = require('express')
parser  = require('body-parser')
cors    = require('cors')

{ itemsRouter }     = require('./items')
{ consumersRouter } = require('./consumers')

app = express()

app.use(parser.json())
app.use(cors())

app.use('/items',     itemsRouter)
app.use('/consumers', consumersRouter)

app.listen(3000)
