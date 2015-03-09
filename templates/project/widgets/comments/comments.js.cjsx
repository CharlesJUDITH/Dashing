Dashing.Comments = React.createClass

  currentIndex: 0

  getInitialState: ->
    current_comment: null

  componentDidMount: ->
    @currentIndex = 0
    @nextComment()
    setInterval @nextComment, 8000

  nextComment: ->
    comments = @state.comments
    if comments
      node = $(@getDOMNode()).find('.comment-container')
      node.fadeOut =>
        @currentIndex = (@currentIndex + 1) % comments.length
        @setState 'current_comment', comments[@currentIndex]
        node.fadeIn()

  render: ->
    <div>
      <h1 className='title'>{@props.title}</h1>
      <div className='comment-container'>
        <h3>
          <img src={@state.current_comment?.avatar} />
          <span className='name'>{@state.current_comment?.name}</span>
        </h3>
        <p className='comment'>“{@state.current_comment?.body}”</p>        
      </div>
      <p className='more-info'>{@props.moreinfo}</p>
    </div>