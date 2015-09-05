class window.PlayersView extends Backbone.View

  class: 'players'

  initialize: ->
    @render()
    @collection.on 'change', @render, @

  render: ->
    @$el.children().detach()
    @$el.append @collection.map (player) ->
      new HandView(model: player).$el   