$ = require 'jquery'
_ = require 'underscore'

backbone = require 'backbone'
marionette = require 'backbone.marionette'
moment = require 'moment'


class HomeLayout extends marionette.LayoutView
  template: require './templates/layout'
  className: 'home_layout'

module.exports = HomeLayout