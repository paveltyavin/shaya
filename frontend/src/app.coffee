require './settings/init'
require 'bootstrap'
backbone = require 'backbone'
marionette = require 'backbone.marionette'

class RootView extends marionette.LayoutView
  el: 'body'
  regions:
    region_main: '#region_main'
  events:
    'click #navbar a': 'onClickLink'

  addLinkClass: (link) =>
    $a = @$("a[data-link='#{link}']")
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
    View = require './home/layout'
    @app.rootView.region_main.show(new View)
    @app.rootView.addLinkClass('home')

  followerList: ->
    View = require './follower/list/layout'
    @app.rootView.region_main.show(new View)
    @app.rootView.addLinkClass('follower')
  followerDetail: (id) ->
    View = require './follower/detail/layout'
    @app.rootView.region_main.show(new View(id: id))
    @app.rootView.addLinkClass('follower')
  chart: ->
    View = require './chart'
    @app.rootView.region_main.show(new View)
    @app.rootView.addLinkClass('chart')


app = new marionette.Application()
app.rootView = new RootView

app.on 'before:start', ->
  new Router(app)

app.on 'start', ->
  backbone.history.start pushState: true

window.addEventListener 'load', ->
  app.start()