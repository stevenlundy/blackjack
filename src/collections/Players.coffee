class window.Players extends Backbone.Collection
  model: Hand

  comparator: 'playerNum'

  initialize: (players, @deck)->


  addPlayer: (name) ->
    debugger;
    @add(new Hand({
      name: name,
      playerNum: @length
      }, @deck))



