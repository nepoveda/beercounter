$ = require('jquery')
React    = require('react')
ReactDOM = require('react-dom')

{ Navbar, Nav, NavItem } = require('react-bootstrap')

{ Pub, Menu, MenuItem } = require('./models')
{ MenuEditation }       = require('./components/menu_editation')

BeercounterNavbar = React.createClass
  linkClicked: () ->
    # whatever

  render: ->
    <Navbar>
      <Navbar.Header>
        <Navbar.Brand>
          BeerCounter
        </Navbar.Brand>
      </Navbar.Header>

      <Nav>
        <NavItem onClick={@linkClicked}>Útrata</NavItem>
        <NavItem onClick={@linkClicked}>Editace lístku</NavItem>
      </Nav>
    </Navbar>

RootComponent = React.createClass
  backendUrl: 'http://localhost:3000'

  getInitialState: ->
    { pub: new Pub('Garch', new Menu()) }

  componentDidMount: ->
    @_ajax('GET', '/menu').then (response) =>
      pub = @state.pub

      for name, item of response.items
        pub.menu.add(name, new MenuItem(name, item.price))

      @setState(pub: pub)

  addItem: (item) ->
    @_ajax('POST', '/menu', { name: item.name, price: item.price }).then (response) =>
      pub = @state.pub

      pub.menu.add(item.name, item)

      @setState(pub: pub)

  removeItem: (name) ->
    @_ajax('DELETE', '/menu?name=' + name).then (response) =>
      pub = @state.pub

      pub.menu.remove(name)

      @setState(pub: pub)

  render: ->
    <div>
      <BeercounterNavbar />

      <div className="container">
        <MenuEditation menu={@state.pub.menu} onAddItem={@addItem} onRemoveItem={@removeItem} />
      </div>
    </div>

  _ajax: (method, path, data = null) ->
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
