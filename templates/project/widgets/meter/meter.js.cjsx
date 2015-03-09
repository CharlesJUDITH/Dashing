Dashing.Meter = React.createClass

  getInitialState: ->
    value: 0,
    displayValue: 0,
    updatedAtMessage: ''

  componentDidMount: ->
    # Need to wait for CSS to be applied... :-(
    $(window).load =>
      meter = $(@getDOMNode()).find('.meter')
      meter.knob
        bgColor: meter.css('background-color'),
        fgColor: meter.css('color'),
        angleOffset: -125,
        angleArc: 250,
        width: 200,
        readOnly: true,
        min: @props.min,
        max: @props.max

  componentDidReceiveData: (data) ->
    $(v: @state.displayValue).animate v: data.value,
      step: (now) =>
        @setState displayValue: now

  componentDidUpdate: (prevProps, prevState) ->
    meter = $(@getDOMNode()).find('.meter')
    meter.val(@state.displayValue).trigger('change')

  render: ->
    <div>
      <h1 className='title'>{@props.title}</h1>
      <input className='meter'
        value={Dashing.shortenedNumber @state.displayValue} />
      <p className='more-info'>{@props.moreinfo}</p>
      <p className='updated-at'>{@state.updatedAtMessage}</p>
    </div>