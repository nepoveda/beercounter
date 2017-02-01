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
      <Button bsStyle="danger" onClick={-> props.onRemove(props.name)}>
        Odebrat
      </Button>
    </td>
  </tr>

MenuListing = React.createClass
  item: (name, item) ->
    <MenuListingItem key={name} name={name} item={item} onRemove={@props.onRemove}/>

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

AddMenuItem = React.createClass
  getInitialState: ->
    name: ''
    price: 0.00

  nameChanged: (event) ->
    @setState(name: event.target.value)

  priceChanged: (event) ->
    @setState(price: event.target.value)

  submit: (event) ->
    # otherwise submit triggers page refresh
    event.preventDefault()

    @props.onSubmit(new MenuItem(@state.name, @state.price))

  render: ->
    <div id="menu-editation">
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
            <Button type="submit" bsStyle="success" onClick={@submit}>
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

module.exports = { MenuEditation }
