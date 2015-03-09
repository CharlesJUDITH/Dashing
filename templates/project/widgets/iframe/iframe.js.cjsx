Dashing.Iframe = React.createClass

  render: ->
    <div>
      <iframe src={@props.url} frameborder=0></iframe>
    </div>