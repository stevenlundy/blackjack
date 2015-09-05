class window.AppView extends Backbone.View
  template: _.template '
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '
  gameControls: '
    <div class="game-controls">
    <button class="deal">deal \'em up</button>
    </div>  
    '

  initialize: ->
    @model.on('change:state', @render, @)
    @model.get('players').on('add', @render, @)
    @addPlayerView = new AddPlayerView({collection: @model.get('players')})
    @render()

  events: 
    'click button.deal': -> @model.deal()


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new PlayersView({collection: @model.get('players')}).el
    @$('.dealer-hand-container').html new DealerView(model: @model.get 'dealerHand').el
    if @model.get('state') isnt 'inProgress' and @model.get('players').length < 5 then @$el.prepend(@addPlayerView.$el)
    if @model.get('state') is 'waitForDeal' and @model.get('players').length > 0 then @$el.prepend(@gameControls)

