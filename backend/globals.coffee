items       = [{ id: 1, name: 'Pivo 10°', price: 24 },
               { id: 2, name: 'Pivo 12°', price: 26 },
               { id: 3, name: 'Kofola',   price: 25 }]
consumers   = [{ id: 1, name: 'Daníg' },
               { id: 2, name: 'Čurák' }]
consumption = [{ consumer_id: 1, consumption: [{ item_id: 2, count: 3 }]},
               { consumer_id: 2, consumption: [{ item_id: 3, count: 2 }]}]

module.exports = { items, consumers, consumption }
