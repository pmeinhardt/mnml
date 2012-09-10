class mnml.views.About extends Backbone.View
  initialize: (options) ->

  template: JST["templates/about"]

  render: -> @$el.html(@template(text: "at app/assets/javascripts/templates/about.jst"))
