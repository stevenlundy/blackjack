class window.PlayersView extends Backbone.View

  class: 'players'

  initialize: ->
    @collection.on 'all', @render, @
    @addPlayerView = new AddPlayerView({collection: @collection})
    @render()

  render: ->
    @$el.children().detach()
    debugger;
    @$el.append @collection.map (player) ->
      new HandView({model: player}).$el 
    @$el.append(@addPlayerView.$el)  
