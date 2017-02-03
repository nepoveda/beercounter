$        = require('jquery')
React    = require('react')
ReactDOM = require('react-dom')

{ Navbar, Nav, NavItem } = require('react-bootstrap')
{ Pub, Menu, MenuItem }  = require('./models')
{ MenuEditation }        = require('./components/menu_editation')
{ CostumerBill }         = require('./components/costumer_bill')

BeercounterNavbar = React.createClass


  linkClicked: (id) ->
    @props.onSetScreen(id)

  render: ->
    <Navbar>
      <Navbar.Header>
        <Navbar.Brand>
          BeerCounter
        </Navbar.Brand>
      </Navbar.Header>

      <Nav>
        <NavItem onClick={@linkClicked(1)}>Útrata</NavItem>
        <NavItem onClick={@linkClicked(2)}>Editace lístku</NavItem>
      </Nav>
    </Navbar>


RootComponent = React.createClass
  backendUrl: 'http://localhost:3000'

  getInitialState: ->
    # initial state is a pub with empty menu

    { pub: new Pub('Garch', new Menu()) }




  componentDidMount: ->
    # when component rendered, request menu from backend

    @_ajax('GET', '/menu').then (response) =>
      pub = @state.pub

      for name, item of response.items
        pub.menu.add(name, new MenuItem(name, item.price))

      @setState(pub: pub)

  addItem: (item) ->
    # add item to backend menu

    @_ajax('POST', '/menu', { name: item.name, price: item.price }).then (response) =>
      # got response - add item to frontend menu

      pub = @state.pub

      pub.menu.add(item.name, item)

      @setState(pub: pub)

  removeItem: (name) ->
    # remove item from backend menu

    @_ajax('DELETE', '/menu?name=' + name).then (response) =>
      # got response - remove item from frontend menu

      pub = @state.pub

      pub.menu.remove(name)

      @setState(pub: pub)

  currectlyShow: <CostumerBill />

  setShowScreen: (id) ->
    switch id
      when id == 1 then @setState(currectlyShow: <MenuEditation menu={@state.pub.menu} onAddItem={@addItem} onRemoveItem={@removeItem} />)
      when id == 2 then @setState(currectlyShow: <CostumerBill />)
      else
        @setState(currectlyShow: <h1> blbečku </h1>)

  render: ->
    <div>
      <BeercounterNavbar onSetScreen={@setShowScreen} />

      <div className="container">
          {@currectlyShow}
      </div>
    </div>

  _ajax: (method, path, data = null) ->
    # ajax helper, returns promise (caller can call .then() on the result)

    params =
      url: @backendUrl + path
      method: method
      contentType: 'application/json'
      dataType: 'json'

    params.data = JSON.stringify(data) if data

    $.ajax(params)

ReactDOM.render(
  <RootComponent />
  document.getElementById('app'))
