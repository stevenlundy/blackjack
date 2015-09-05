# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'dealerHand', deck.dealDealer()
    @set 'players', new Players(deck.dealPlayer(1))
    @set 'currentPlayer', @get('players').first()
    @get('currentPlayer').set 'state', 'playing'

    # listen for change on state of hands in players
    @get('currentPlayer').on 'change:state', @chooseNextTurn, @
    # (@get 'players').on 'change:state', @setTurn, @
    # (@get 'dealerHand').on 'change:state', @endGame, @



  chooseNextTurn: -> 
    nextPlayer = @get('players').findWhere { 'state':'playing' }
    if nextPlayer? 
      @setCurrentPlayer(nextPlayer)
    else 
      @setCurrentPlayer(null)
      @dealerTurn()


  dealerTurn: ->
    if @get('players').every (player) ->
      player.get('state') is 'lost' or player.get('state') is 'blackJack' 
    then @endGame()
    else 
      @get('dealerHand').play() 
      @endGame()

  endGame: -> 
    console.log 'its over'
    waitingPlayers = @get('players').where({state: 'standing'})
    dealerScore = @get('dealerHand').minScore()
    if dealerScore > 21 then _.each waitingPlayers, (player) ->
      player.set('state', 'won')
    _.each waitingPlayers, (player) ->
      if player.minScore() > dealerScore then player.set 'state', 'won'
      else player.set 'state', 'lost'


  #handles changing the event listner
  setCurrentPlayer: (nextPlayer) ->
    @get('currentPlayer').off 'change:state'
    @set('currentPlayer', nextPlayer);
    if nextPlayer?
      @get('currentPlayer').on 'change:state', @chooseNextTurn, @
      nextPlayer.set 'state', 'playing' 
















  # then @endGame()
  #     else @get('dealerHand').play()


    #a player takes a turn -- > state changes

      # --> standing


      # --> lost


      # --> blackJack

    #choose who goes next
      #repeat turn for player

    #when all players have played

    #dealers turn:
      # --> has everyone lost, or blackjacked
        # if so, end game

      # --> if anyone is standing
        #dealer.play()

        #update the state of waiting players




    # chooseWhoGoesNext
    

    
    # playersTakeTurns





    # dealerPlaysOut





















  # setTurn: ->
  #   
    

  # endGame: ->
  #   #unbind call back
  #   (@get 'players').off 'change:state'
  #   (@get 'dealerHand').off 'change:state'
  #   #we have get dealer score
  #   dealerScore = @get('dealerHand').minScore() 
  #   #compare each player who to dealer and update state
  #   @get('players').each (player) =>
  #     if player.minScore() < 21 and player.minScore() > dealerScore 
  #       player.set 'state', 'won'
  #       @get('dealerHand').set 'state' , 'lost'
  #     else player.set 'state', 'lost'

  # # @get('dealerHand').play ,(@get 'dealerHand')
    


  #   #resume work here later...
  #   # (@get 'playerHand').on 'lost'
  #   # (@get 'playerHand').on 'won'


  # #beforeTurn
  # #playing
  #   # ---> lost
  #   # ---> standing --- > won
  #   # ---> won

  # #endOfTurn
  # #gameState: inactiv
  #   #dealer has a choice--
  #     #play
  #     #declare victory

