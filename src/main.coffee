React    = require('react')
ReactDOM = require('react-dom')

{ Row, Col, Navbar, Nav, NavItem, Table,
  Form, FormGroup, FormControl, ControlLabel, Button } = require('react-bootstrap')

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

  remove: (name) ->
    delete @items[name]

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
    <td>
      <Button bsStyle="danger" onClick={-> props.onRemove(props.name)}>
        Odebrat
      </Button>
    </td>
  </tr>

MenuListing = React.createClass
  item: (name, item) ->
    <MenuListingItem key={name} name={name} item={item} onRemove={@props.onRemove}/>

  render: ->
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
          {@item(name, item) for name, item of @props.menu.items}
        </tbody>
      </Table>
    </div>

AddMenuItem = React.createClass
  getInitialState: ->
    name: ''
    price: 0.00

  nameChanged: (event) ->
    @setState(name: event.target.value)

  priceChanged: (event) ->
    @setState(price: event.target.value)

  submit: (event) ->
    event.preventDefault()

    @props.onSubmit(new MenuItem(@state.name, @state.price))

  render: ->
    <div id="#menu-editation">
      <h3>Přidat položku</h3>

      <Form horizontal>
        <FormGroup controlId="name">
          <Col componentClass={ControlLabel} sm={2}>
            Název
          </Col>
          <Col sm={10}>
            <FormControl type="text" placeholder="Název"
              value={@state.name} onChange={@nameChanged} />
          </Col>
        </FormGroup>

        <FormGroup controlId="price">
          <Col componentClass={ControlLabel} sm={2}>
            Cena
          </Col>
          <Col sm={10}>
            <FormControl type="text"
              value={@state.price} onChange={@priceChanged} />
          </Col>
        </FormGroup>

        <FormGroup>
          <Col smOffset={2} sm={10}>
            <Button type="submit" onClick={@submit}>
              Přidat
            </Button>
          </Col>
        </FormGroup>
      </Form>
    </div>

MenuEditation = (props) ->
  <Row>
    <Col xs=6>
      <MenuListing menu={props.menu} onRemove={props.onRemoveItem} />
    </Col>
    <Col xs=6>
      <AddMenuItem onSubmit={props.onAddItem} />
    </Col>
  </Row>

RootComponent = React.createClass
  getInitialState: ->
    menu = new Menu()

    menu.add('desitka',   new MenuItem('Pivo 10°', 24.00))
    menu.add('dvanactka', new MenuItem('Pivo 12°', 26.00))
    menu.add('kofola',    new MenuItem('Kofola',   26.00))

    { pub: new Pub('Garch', menu) }

  addItem: (item) ->
    pub = @state.pub

    pub.menu.add(item.name, item)

    @setState(pub: pub)

  removeItem: (name) ->
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

ReactDOM.render(
  <RootComponent />
  document.getElementById('app'))
