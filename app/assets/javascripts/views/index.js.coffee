class mnml.views.Index extends Backbone.View
  initialize: (options) ->

  template: JST["templates/index"]

  render: -> @$el.html(@template(text: "at app/assets/javascripts/templates/index.jst"))
