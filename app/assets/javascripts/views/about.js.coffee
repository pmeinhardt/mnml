class mnml.views.About extends Backbone.View
  initialize: (options) ->

  template: HBS["templates/about"]

  render: -> @$el.html(@template(text: "at app/assets/javascripts/templates/about.hbs"))
