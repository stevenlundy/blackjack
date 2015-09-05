# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'dealerHand', new Hand({name: 'Dealer', cards:[]}, deck, true)
    @set 'players', new Players([], deck)
    @set 'currentPlayer', new Hand()
    @set 'state', 'waitForPlayers'

    # listen for change on state of hands in players
    @get('currentPlayer').on 'change:state', @chooseNextTurn, @
    @get('players').on 'split', @splitHand, @
    @get('players').on 'add', => @set 'state', 'waitForDeal' 
    
  
  #Starts a game
  deal: ->
    @set 'state', 'inProgress'
    @clearCards()
    deck = @get 'deck'
    @shuffleDeck() if deck.length < (@get('players').length + 1)*4
    @get('players').each (player) ->
      player.get('cards').push(deck.pop())
    @get('dealerHand').get('cards').push(deck.pop().flip())
    
    @get('players').each (player) ->
      player.get('cards').push(deck.pop())
      player.set 'state', 'beforeTurn'
    @get('dealerHand').get('cards').push(deck.pop())

    @get('dealerHand').dealt();
    
    @setCurrentPlayer(@get('players').first())
    @get('currentPlayer').set 'state', 'playing'

  clearCards: ->
    @get('players').each (player) -> 
      player.set 'cards', []
    @get('dealerHand').set 'cards', []

  shuffleDeck: ->
    @set('deck', new Deck())
    @get('players').each (player) =>
      player.deck = @get('deck')
    @get('dealerHand').deck = @get('deck')

  #split hands
  splitHand: (player) ->
    playerCard2 = player.get('cards').pop()
    playerCard1 = player.get('cards').pop()

    #using get and set so that change events fire in view
    @get('players').add new Hand({
      playerNum: player.get('playerNum')
      name: player.get('name') + ' split'
      cards: [playerCard2]
      # bet
      }, @get('deck'))

    player.set('cards',[playerCard1])

  #detirmine next turn
  chooseNextTurn: -> 
    nextPlayer = @get('players').findWhere { 'state':'beforeTurn' }
    if nextPlayer? 
      @setCurrentPlayer(nextPlayer)
    else 
      @setCurrentPlayer(null)
      @dealerTurn()

  #handles changing the event listner
  setCurrentPlayer: (nextPlayer) ->
    if @get('currentPlayer')?
      @get('currentPlayer').off 'change:state'
    @set('currentPlayer', nextPlayer);
    if nextPlayer?
      nextPlayer.set 'state', 'playing' 
      @get('currentPlayer').on 'change:state', @chooseNextTurn, @

  dealerTurn: ->
    if @get('players').every (player) ->
      player.get('state') is 'lost' or player.get('state') is 'blackJack' 
    then @endGame()
    else 
      @get('dealerHand').play() 
      @endGame()

  endGame: -> 
    console.log 'its over'
    @set 'state', 'waitForDeal'
    waitingPlayers = @get('players').where({state: 'standing'})
    dealerScore = @get('dealerHand').minScore()
    if dealerScore > 21 then _.each waitingPlayers, (player) ->
      player.set('state', 'won')
    else  
      _.each waitingPlayers, (player) ->
        # debugger;
        if player.minScore() > dealerScore then player.set 'state', 'won'
        else player.set 'state', 'lost'



















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

