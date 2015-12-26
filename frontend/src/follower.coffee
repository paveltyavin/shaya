$ = require 'jquery'
_ = require 'underscore'

backbone = require 'backbone'
marionette = require 'backbone.marionette'
moment = require 'moment'


class Follower extends backbone.Model
class FollowerCollection extends backbone.Collection
  parse: (response) =>
    @count = response.count
    return response.results

class FollowerDetailLayout extends marionette.LayoutView
  template: require './templates/follower_detail'

class FollowerListLayout extends marionette.LayoutView
  template: require './templates/follower_list'

module.exports =
  FollowerListLayout: FollowerListLayout
  FollowerDetailLayout: FollowerDetailLayout