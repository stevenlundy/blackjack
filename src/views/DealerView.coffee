class window.DealerView extends Backbone.View
  className: 'hand dealer'

  template: _.template '<h2>
                        <%= name %>
                      (<span class="score"></span>)
                        </h2>'

  initialize: ->
    @model.on 'hit', @render, @
    @model.on 'reveal', @render, @
    @model.on 'dealt', @render, @
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.append @model.get('cards').map (card) ->
      new CardView(model: card).$el
    @$('.score').text @model.minScore()