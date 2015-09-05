# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'players', new Players(deck.dealPlayer(1))
    @set 'dealerHand', deck.dealDealer()

    @get('players').first().set 'state', 'playing'



    # listen for stand button, and make dealer start playing
    # (@get 'players').on 'standing', @get('dealerHand').play ,(@get 'dealerHand')
    #resume work here later...
    # (@get 'playerHand').on 'lost'
    # (@get 'playerHand').on 'won'


  #beforeTurn
  #playing
    # ---> lost
    # ---> standing --- > won
    # ---> won

  #endOfTurn
  #gameState: inactiv
    #dealer has a choice--
      #play
      #declare victory

