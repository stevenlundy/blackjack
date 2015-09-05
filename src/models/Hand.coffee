class window.Hand extends Backbone.Model
  defaults:{
    'state':'beforeTurn'
  }
  initialize: (params, @deck, @isDealer) ->

  hit: ->
    @get('cards').push(@deck.pop())
    @trigger('hit', @)
    if @minScore() is 21 then @set 'state', 'won'
    if @minScore() > 21 then @set 'state', 'lost'
    _.last(@get('cards'))

  stand: -> 
    @set('state', 'standing')

  hasAce: -> _.reduce @get('cards'), (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> _.reduce @get('cards'), (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]
  
  play: ->
    _.first(@get('cards')).flip()
    @trigger('reveal', @)
    while @minScore() < 17 then @hit()
    @stand()


