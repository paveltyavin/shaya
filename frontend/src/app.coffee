require 'config'
require 'bootstrap'
require './settings'
marionette = require 'backbone.marionette'
backbone = require 'backbone'

ChartView = require './chart'
follower_module = require './follower'

class RootView extends marionette.LayoutView
  el: 'body'
  regions:
    region_main: '#region_main'
    region_chart: '#region_chart'

class TestView extends marionette.ItemView
  template: -> return 'test'

class Router extends marionette.AppRouter
  initialize: (app) ->
    @app = app

  routes:
    '': 'followerList'
    ':id/': 'followerDetail'

  followerList: ->
    @app.rootView.region_main.show(new follower_module.FollowerListLayout)
  followerDetail: (id) ->
    @app.rootView.region_main.show(new follower_module.FollowerDetailLayout(id: id))

app = new marionette.Application()
app.rootView = new RootView

app.on 'before:start', ->
  new Router(app)

app.on 'start', ->
  backbone.history.start pushState: true
  app.rootView.region_chart.show(new ChartView)

window.addEventListener 'load', ->
  app.start()