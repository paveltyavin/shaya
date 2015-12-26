$ = require 'jquery'
_ = require 'underscore'

backbone = require 'backbone'
marionette = require 'backbone.marionette'
moment = require 'moment'

class Follower extends backbone.Model
  url: =>
    "/api/follower/#{@id}/"

class FollowerItemView extends marionette.ItemView
  template: require './templates/detail/item'

class FollowerDetailLayout extends marionette.LayoutView
  template: require './templates/detail/layout'
  className: 'follower_detail_layout'
  regions:
    region_item: '.region_item'
  events:
    'click .link_list': 'onClickLinkList'

  onClickLinkList: (event)=>
    event.preventDefault()
    backbone.history.navigate '', trigger: true

  initialize: (options)=>
    @model = new Follower(id: options.id)
    @item_view = new FollowerItemView(model: @model)
  onRender: =>
    @model.fetch().done =>
      @region_item.show(@item_view)

module.exports = FollowerDetailLayout