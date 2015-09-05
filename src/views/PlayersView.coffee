class window.PlayersView extends Backbone.View

  class: 'players'

  initialize: ->
    @collection.on 'all', @render, @
    @render()

  render: ->
    @$el.children().detach()
    @$el.append @collection.map (player) ->
      new HandView({model: player}).$el   
