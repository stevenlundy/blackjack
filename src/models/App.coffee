# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    # listen for stand button, and make dealer start playing
    (@get 'playerHand').on 'standing', @get('dealerHand').play ,(@get 'dealerHand')
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

