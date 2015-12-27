require 'config'
require 'bootstrap'
require './settings'
marionette = require 'backbone.marionette'
backbone = require 'backbone'

ChartView = require './chart'
FollowerDetailLayout = require './follower/detail/layout'
FollowerListLayout = require './follower/list/layout'
HomeLayout = require './home/layout'

class RootView extends marionette.LayoutView
  el: 'body'
  regions:
    region_main: '#region_main'
  events:
    'click #navbar a': 'onClickLink'

  addLinkClass: (link) =>
    $a = @$("a[href='#{link}']")
    if $a.length > 0
      $li = $a.parent()
      $li.siblings().removeClass 'active'
      $li.addClass 'active'

  onClickLink: (event)=>
    event.preventDefault()
    $target = $(event.target)
    link = $target.attr 'href'
    @addLinkClass(link)
    backbone.history.navigate link, trigger: true

class Router extends marionette.AppRouter
  initialize: (app) ->
    @app = app

  routes:
    '': 'home'
    'chart/': 'chart'
    'follower/': 'followerList'
    'follower/:id/': 'followerDetail'

  home: ->
    @app.rootView.region_main.show(new HomeLayout)
    @app.rootView.addLinkClass('/')

  followerList: ->
    @app.rootView.region_main.show(new FollowerListLayout)
    @app.rootView.addLinkClass('/follower/')
  followerDetail: (id) ->
    @app.rootView.region_main.show(new FollowerDetailLayout(id: id))
    @app.rootView.addLinkClass('/follower/')
  chart: ->
    @app.rootView.region_main.show(new ChartView)
    @app.rootView.addLinkClass('/chart/')


app = new marionette.Application()
app.rootView = new RootView

app.on 'before:start', ->
  new Router(app)

app.on 'start', ->
  backbone.history.start pushState: true

window.addEventListener 'load', ->
  app.start()