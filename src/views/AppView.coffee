class window.AppView extends Backbone.View
  template: _.template '
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '
  
  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

