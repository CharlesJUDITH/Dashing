Dashing.Graph = React.createClass

  graph: null

  getInitialState: ->
    displayedValue: null,
    points: null

  componentDidMount: ->
    # Need to wait for CSS to be applied... :-(
    $(window).load =>
      widget = @getDOMNode()
      container = $(widget).parent()
      @graph = new Rickshaw.Graph
        element: widget
        width: $(container).outerWidth()
        height: $(container).outerHeight()
        renderer: @props.graphtype
        series: [
          {
          color: "#fff",
          data: [{x:0, y:0}]
          }
        ]

      x_axis = new Rickshaw.Graph.Axis.Time(graph: @graph)
      y_axis = new Rickshaw.Graph.Axis.Y(graph: @graph, tickFormat: Rickshaw.Fixtures.Number.formatKMBT)

      @graph.series[0].data = @state.points if @state.points
      @graph.render()

  componentDidUpdate: (prevProps, prevState) ->
    if @graph
      @graph.series[0].data = @state.points
      @graph.render()

  currentValue: ->
    return @state.displayedValue if @state.displayedValue
    points = @state.points
    if points
      points[points.length - 1].y

  render: ->
    <div>
      <h1 className='title'>{@props.title}</h1>
      <h2 className='value'>
        {@props.prefix}{Dashing.prettyNumber @currentValue()}
      </h2>
      <p className='more-info'>{@props.moreinfo}</p>
    </div>