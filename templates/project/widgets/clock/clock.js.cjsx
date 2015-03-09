Dashing.Clock = React.createClass

  componentDidMount: ->
    @startTime()
    @interval = setInterval @startTime, 500

  componentWillUnmount: ->
    clearInterval @interval

  getInitialState: ->
    time: "",
    date: ""

  formatTime: (i) ->
    if i < 10 then "0" + i else i

  startTime: ->
    today = new Date()
    h = today.getHours()
    m = today.getMinutes()
    s = today.getSeconds()
    m = @formatTime(m)
    s = @formatTime(s)
    @setState
      time: h + ":" + m + ":" + s
      date: today.toDateString()

  render: ->
    <div>
      <h1>{@state.date}</h1>
      <h2>{@state.time}</h2>
    </div>
