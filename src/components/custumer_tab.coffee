React    = require('react')

{ Row, Col, Table, Form, FormGroup, FormControl, ControlLabel, Button } =
  require('react-bootstrap')

{ MenuItem } = require('../models')

MenuListingItem = (props) ->
  item = props.item

  <tr>
    <td>{item.name}</td>
    <td>{item.price}</td>
    <td className="actions">
      <Button bsStyle="success">
        Přidej
      </Button>
    </td>
  </tr>

MenuListing = React.createClass
  item: (name, item) ->
    <MenuListingItem key={name} name={name} item={item} />

  render: ->
    <div id="menu-listing">
      <h3>Naše menu</h3>
      <Table striped={true} hover={true}>
        <thead>
          <tr>
            <th>Název</th>
            <th>Cena</th>
            <th className="actions"></th>
          </tr>
        </thead>

        <tbody>
          {@item(name, item) for name, item of @props.menu.items}
        </tbody>
      </Table>
    </div>

CustumerTab = (props) ->
  <Row>
    <Col xs=6>
      <MenuListing menu={props.menu} />
    </Col>
  </Row>

module.exports = { CustumerTab }
