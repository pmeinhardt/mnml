class mnml.views.Index extends Backbone.View
  initialize: (options) ->

  template: HBS["templates/index"]

  render: -> @$el.html(@template(
    text: "at app/assets/javascripts/templates/index.hbs", date: new Date(2012, 8, 10, 13)))
