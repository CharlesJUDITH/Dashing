Dashing.Image = React.createClass

  render: ->
    <div>
      <img src={'/assets' + @props.image} width={@props.width} />
    </div>