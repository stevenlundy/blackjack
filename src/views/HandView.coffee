class window.HandView extends Backbone.View
  className:'hand'
  template: _.template '<h2>Player <%= name %>
                        (<span class="score"></span>)
                        <button class="hit-button">Hit</button> 
                        <button class="stand-button">Stand</button>
                        </h2>'
  stateDivs:
    standing:'<h1 class="standing">I Am Waiting</h1>' 
    won: '<h1 class="won">I have Beaten the Dealer fair and square</h1>'
    lost: '<h1 class="lost">I have lost the gAMe and shAMed my fAMily</h1>'
    beforeTurn:'<h1 class="beforeTurn"></h1>' 
    playing:'<h1 class="playing"></h1>'
    blackJack:'<h1 class="blackJack">Winner Winner Chicken Dinner</h1>'
  
  splitButton: '<button class="split-button">Split</button>'

  initialize: ->
    #this wont work!
    # debugger;
    @model.on 'hit', @render, @
    @model.on 'change', @render, @

    @render()


  events:
    'click .hit-button': -> @model.hit()
    'click .stand-button': -> @model.stand()
    'click .split-button': -> @model.split()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.find('h2').append(@splitButton) if @model.canSplit() 
    @$el.find('button').hide() unless @model.get('state') is 'playing'
    @$el.append @model.get('cards').map (card) ->
      new CardView(model: card).$el
    @$('.score').text @model.minScore()
    @$el.prepend(@stateDivs[@model.get('state')])



   # if(isDealer){ %>Dealer<% }else{ %>You<% }