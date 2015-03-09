Dashing.Text = React.createClass

  getInitialState: ->
    updatedAtMessage: ''

  render: ->
    <div>
      <h1 className='title'>{@props.title}</h1>
      <h3>{@props.text}</h3>
      <p className='more-info'>{@props.moreinfo}</p>
      <p className='updated-at'>{@state.updatedAtMessage}</p>
    </div>