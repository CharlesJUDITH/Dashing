Dashing.Number = React.createClass

  getInitialState: ->
    displayCurrent: 0,
    current: 0,
    last: 0

  componentDidReceiveData: (data) ->
    $(v: @state.current).animate v: data.current,
      step: (now) =>
        @setState displayCurrent: parseInt now

  difference: ->
    if @state.last == 0
      return 0
    Math.round(
      Math.abs(@state.displayCurrent - @state.last) / @state.last * 100)

  arrow: ->
    if @state.current > @state.last then 'icon-arrow-up' else 'icon-arrow-down'

  render: ->
    <div>
      <h1 className='title'>{@props.title}</h1>
      <h2 className='value'>
        {@props.prefix}
        {Dashing.shortenedNumber @state.displayCurrent}
        {@props.suffix}
      </h2>
      <p className='change-rate'>
        <i className={@arrow()}></i> <span>{@difference()}%</span>
      </p>
      <p className='more-info'>{@props.moreinfo}</p>
      <p className='updated-at'>{@state.updatedAtMessage}</p>
    </div>