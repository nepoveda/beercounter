$        = require('jquery')
React    = require('react')
ReactDOM = require('react-dom')

{ Navbar, Nav, NavItem } = require('react-bootstrap')
{ Pub, Menu, MenuItem, CustumerItem }  = require('./models')
{ MenuEditation }        = require('./components/menu_editation')
{ CustumerTab }          = require('./components/custumer_tab')

BeercounterNavbar = (props) ->
  <Navbar>
    <Navbar.Header>
      <Navbar.Brand>
        BeerCounter
      </Navbar.Brand>
    </Navbar.Header>

    <Nav>
      <NavItem onClick={-> props.onSetScreen('customer tab')}>Útrata</NavItem>
      <NavItem onClick={-> props.onSetScreen('menu editation')}>Editace lístku</NavItem>
    </Nav>
  </Navbar>

RootComponent = React.createClass
  backendUrl: 'http://localhost:3000'

  getInitialState: ->
    pub: new Pub('Garch', new Menu())
    shownScreen: 'customer tab'

  componentDidMount: ->
    # when component rendered, request menu from backend

    @_ajax('GET', '/items').then (response) =>
      pub = @state.pub

      for item in response.items
        pub.menu.add(item.name, new MenuItem(item.name, item.price))

      @setState(pub: pub)

  addItem: (item) ->
    # add item to backend menu

    @_ajax('POST', '/items', { name: item.name, price: item.price }).then (response) =>
      # got response - add item to frontend menu

      pub = @state.pub

      pub.menu.add(item.name, item)

      @setState(pub: pub)

  removeItem: (name) ->
    # remove item from backend menu

    @_ajax('DELETE', '/items?name=' + name).then (response) =>
      # got response - remove item from frontend menu

      pub = @state.pub

      pub.menu.remove(name)

      @setState(pub: pub)

  render: ->
    mainComponent = switch @state.shownScreen
      when 'customer tab'
        <CustumerTab menu={@state.pub.menu} />
      when 'menu editation'
        <MenuEditation menu={@state.pub.menu} onAddItem={@addItem} onRemoveItem={@removeItem} />

    <div>
      <BeercounterNavbar onSetScreen={(id) => @setState(shownScreen: id)} />

      <div className="container">
        {mainComponent}
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
