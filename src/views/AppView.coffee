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
    @$('.player-hand-container').html new PlayersView({collection: @model.get('players')}).el
    @$('.dealer-hand-container').html new DealerView(model: @model.get 'dealerHand').el

