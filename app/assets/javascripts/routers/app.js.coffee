class mnml.routers.App extends Backbone.Router
  routes:
    "":       "index"
    "index":  "index"
    "about":  "about"

  index: ->
    @indexView ||= new mnml.views.Index(el: $("#wrapper"))
    @indexView.render()

  about: ->
    @aboutView ||= new mnml.views.About(el: $("#wrapper"))
    @aboutView.render()
