class window.Hand extends Backbone.Model
  defaults:{
    'state':'beforeTurn'
  }
  initialize: (params, @deck, @isDealer) ->

  dealt: ->
    @trigger('dealt', @)

  hit: ->
    @get('cards').push(@deck.pop())
    @trigger('hit', @)
    if @minScore() is 21 then @set 'state', 'won'
    if @minScore() > 21 then @set 'state', 'lost'
    _.last(@get('cards'))

  stand: -> 
    @set('state', 'standing')

  split: ->
    @trigger('split',@)

  hasAce: -> _.reduce @get('cards'), (memo, card) ->
    memo or card.get('value') is 1
  , 0

  canSplit: ->
    cards = @get('cards')
    cards.length is 2 and cards[0].get('rank') is cards[1].get('rank')

  oldMinScore: -> _.reduce @get('cards'), (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@oldMinScore(), @oldMinScore() + 10 * @hasAce()]

  minScore: ->
    filteredScores = @scores().filter (score) -> score <= 21
    if filteredScores.length > 0
      Math.max.apply null,  filteredScores
    else @scores()[0]
  
  play: ->
    _.first(@get('cards')).flip()
    @trigger('reveal', @)
    while @minScore() < 17 then @hit()
    @stand()


