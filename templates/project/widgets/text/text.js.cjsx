Dashing.Text = React.createClass

  getInitialState: ->
    updateAtMessage: null,
    text: ''

  componentDidReceiveData: (data) ->
    $(v: @state.text).animate v: data.text,
      step: (now) =>
        @setState displayText: now

  render: ->
    <div>
      <h1 className='title'>{@props.title}</h1>
      <h3 className='text'>{@state.displayText}</h3>
      <p className='updated-at'>{@state.updatedAtMessage}</p>
    </div>
