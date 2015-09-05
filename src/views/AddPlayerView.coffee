class window.AddPlayerView extends Backbone.View

  template: _.template('<input class="player-name-input" type="text" />
                        <button class="add-player">Deal me in!</button>
                        ')

  initialize: ->
    @render()

  events: 
    'click button.add-player': ->
      @collection.addPlayer @$el.find('.player-name-input').val()
      @$el.find('.player-name-input').val('') 

  render: ->
    @$el.html @template()