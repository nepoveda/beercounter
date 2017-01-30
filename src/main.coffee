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
          Beercounter
        </Navbar.Brand>
      </Navbar.Header>

      <Nav>
        <NavItem onClick={@linkClicked}>Útrata</NavItem>
        <NavItem onClick={@linkClicked}>Editace lístku</NavItem>
      </Nav>
    </Navbar>


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
