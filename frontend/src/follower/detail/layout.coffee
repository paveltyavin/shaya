$ = require 'jquery'
_ = require 'underscore'

backbone = require 'backbone'
marionette = require 'backbone.marionette'
moment = require 'moment'

class Follower extends backbone.Model
  url: =>
    "/api/follower/#{@id}/"

class ItemView extends marionette.ItemView
  template: require './templates/item'

class Layout extends marionette.LayoutView
  template: require './templates/layout'
  className: 'follower_detail_layout'
  regions:
    region_item: '.region_item'

  initialize: (options)=>
    @model = new Follower(id: options.id)
    @item_view = new ItemView(model: @model)
  onRender: =>
    @model.fetch().done =>
      @region_item.show(@item_view)

module.exports = Layout