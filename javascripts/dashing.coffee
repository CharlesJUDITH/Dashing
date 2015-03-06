#= require jquery
#= require es5-shim
#= require react.min


class window.Dashing
  constructor: ->

Dashing.debugMode = false
Dashing.eventSource = null
Dashing.lastEvents = {}
Dashing.widgets = {}

Dashing.prettyNumber = (num) ->
  num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") unless isNaN(num)

Dashing.dashize = (str) ->
  dashes_rx1 = /([A-Z]+)([A-Z][a-z])/g;
  dashes_rx2 = /([a-z\d])([A-Z])/g;
  return str.replace(dashes_rx1, '$1_$2').replace(dashes_rx2, '$1_$2').replace(/_/g, '-').toLowerCase()

Dashing.shortenedNumber = (num) ->
  return num if isNaN(num)
  if num >= 1000000000
    (num / 1000000000).toFixed(1) + 'B'
  else if num >= 1000000
    (num / 1000000).toFixed(1) + 'M'
  else if num >= 1000
    (num / 1000).toFixed(1) + 'K'
  else
    num

Dashing.renderWidget = (node, data) ->
  view = $(node).data 'view'
  id = $(node).attr 'id'
  style = Dashing.dashize view
  $(node).addClass "widget widget-#{style} #{style}"
  widget = React.render React.createElement(Dashing[view], data), node
  Dashing.widgets[id] ||= []
  Dashing.widgets[id].push(widget)
  if Dashing.lastEvents[id]
    widget.setState Dashing.lastEvents[id]

Dashing.renderWidgets = () ->
  rendered = false
  $('div[data-view]').each (index, node) =>
    Dashing.renderWidget node, $(node).data()
    rendered = true
  return rendered

Dashing.updatedAtMessage = (updatedAt) ->
  timestamp = new Date(updatedAt * 1000)
  hours = timestamp.getHours()
  minutes = ("0" + timestamp.getMinutes()).slice(-2)
  "Last updated at #{hours}:#{minutes}"

Dashing.startEventStream = () ->
  Dashing.eventSource = new EventSource('events')
  Dashing.eventSource.addEventListener 'open', (e) ->
    console.log("Connection opened", e)

  Dashing.eventSource.addEventListener 'error', (e) ->
    console.log("Connection error", e)
    if (e.currentTarget.readyState == EventSource.CLOSED)
      console.log("Connection closed")
      setTimeout (->
        window.location.reload()
      ), 5*60*1000

  Dashing.eventSource.addEventListener 'message', (e) ->
    data = JSON.parse(e.data)
    if Dashing.lastEvents[data.id]?.updatedAt != data.updatedAt
      if Dashing.debugMode
        console.log("Received data for #{data.id}", data)
      if Dashing.widgets[data.id]?.length > 0
        data['updatedAtMessage'] = Dashing.updatedAtMessage(data.updatedAt)
        Dashing.lastEvents[data.id] = data
        for widget in Dashing.widgets[data.id]
          widget.setState data

$(document).ready ->
  if Dashing.renderWidgets()
    Dashing.startEventStream()

