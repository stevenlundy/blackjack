class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %>
                        (<span class="score"></span>)
                        <button class="hit-button">Hit</button> 
                        <button class="stand-button">Stand</button></h2>'

  initialize: ->
    @collection.on x => @render()
    @render()

  events:
    'click .hit-button': -> @collection.hit()
    'click .stand-button': -> @collection.stand()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]

