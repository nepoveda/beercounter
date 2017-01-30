React    = require('react')
ReactDOM = require('react-dom')

{ Row, Col, Navbar, Nav, NavItem, Table } = require('react-bootstrap')

## Models

class MenuItem
  constructor: (name, price) ->
    @name  = name
    @price = price

class Menu
  constructor: (items = {}) ->
    @items = items

  add: (name, item) ->
    @items[name] = item

class Pub
  constructor: (name, menu) ->
    @name = name
    @menu = menu

## Components

BeercounterNavbar = React.createClass
  linkClicked: () ->
    # whatever

  render: ->
    <Navbar>
      <Navbar.Header>
        <Navbar.Brand>
          Beercounter
        </Navbar.Brand>
      </Navbar.Header>

      <Nav>
        <NavItem onClick={@linkClicked}>Útrata</NavItem>
        <NavItem onClick={@linkClicked}>Editace lístku</NavItem>
      </Nav>
    </Navbar>

MenuListingItem = (props) ->
  item = props.item

  <tr>
    <td>{item.name}</td>
    <td>{item.price}</td>
  </tr>

MenuListing = (props) ->
  <div id="#menu-listing">
    <h3>Naše menu</h3>
    <Table striped={true} hover={true}>
      <thead>
        <tr>
          <th>Název</th>
          <th>Cena</th>
        </tr>
      </thead>

      <tbody>
        {<MenuListingItem key={name} item={item} /> for name, item of props.menu.items}
      </tbody>
    </Table>
  </div>

AddMenuItem = React.createClass
  render: ->
    <p>pridat polozku do menu</p>

MenuEditation = (props) ->
  <Row>
    <Col xs=6>
      <MenuListing menu={props.menu} />
    </Col>
    <Col xs=6>
      <AddMenuItem />
    </Col>
  </Row>

RootComponent = React.createClass
  getInitialState: ->
    menu = new Menu()

    menu.add('desitka',   new MenuItem('Pivo 10°', 24.00))
    menu.add('dvanactka', new MenuItem('Pivo 12°', 26.00))
    menu.add('kofola',    new MenuItem('Kofola',   26.00))

    { pub: new Pub('Garch', menu) }

  render: ->
    <div>
      <BeercounterNavbar />
      <div className="container">
        <MenuEditation menu={@state.pub.menu} />
      </div>
    </div>

ReactDOM.render(
  <RootComponent />
  document.getElementById('app'))
