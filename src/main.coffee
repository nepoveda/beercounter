React    = require('react')
ReactDOM = require('react-dom')

{ Row, Col, Navbar, Nav, NavItem } = require('react-bootstrap')

BeercounterNavbar = React.createClass
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

MainComponent = (props) ->
  <div className="container">
    <Row>
      <p>Tady bude hlavní obsah</p>
    </Row>
  </div>

RootComponent = (props) ->
  <div>
    <BeercounterNavbar />
    <MainComponent />
  </div>

ReactDOM.render(
  <RootComponent />
  document.getElementById('app'))
