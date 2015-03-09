ListRow = React.createClass

  render: ->
    <li>
      <span className="label">{@props.label}</span>
      <span className="value">{@props.value}</span>
    </li>


Dashing.List = React.createClass

  getInitialState: ->
    items: []

  renderRows: ->
    rows = for item in @state.items
      <ListRow {...item} />

  renderUnordered: ->
    <ul className='list-nostyle'>{@renderRows()}</ul>

  renderOrdered: ->
    <ol>{@renderRows()}</ol>

  render: ->
    <div>
      <h1 className='title'>{@props.title}</h1>
      {if @props.unordered then @renderUnordered() else @renderOrdered()}
      <p className='more-info'>{@props.moreinfo}</p>
      <p className='updated-at'>{@state.updatedAtMessage}</p>
    </div>