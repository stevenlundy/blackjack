class window.HandView extends Backbone.View
  className:'hand'
  template: _.template '<h2>Player <%= player %>
                        (<span class="score"></span>)
                        <button class="hit-button">Hit</button> 
                        <button class="stand-button">Stand</button></h2>'
  initialize: ->
    #this wont work!
    @model.on 'hit', @render, @
    @render()


  events:
    'click .hit-button': -> @model.hit()
    'click .stand-button': -> @model.stand()

  render: ->
    @$el.children().detach()
    @$el.html @template @model
    @$el.append @model.get('cards').map (card) ->
      new CardView(model: card).$el
    @$('.score').text @model.scores()[0]