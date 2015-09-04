class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: (player) -> new Hand { cards:[@pop(), @pop()], player: player }, @, false

  dealDealer: -> new Hand { cards:[@pop().flip(), @pop()] }, @, true

