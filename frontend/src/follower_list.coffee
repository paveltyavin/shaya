$ = require 'jquery'
_ = require 'underscore'

backbone = require 'backbone'
marionette = require 'backbone.marionette'
moment = require 'moment'

class FilterModel extends backbone.Model
  defaults:
    page: 1
    active: null

class Follower extends backbone.Model
class FollowerCollection extends backbone.Collection
  url: '/api/follower/'
  parse: (response) =>
    @count = response.count
    return response.results


class FollowerItemView extends marionette.ItemView
  template: require './templates/list/item'
  triggers:
    'click': 'click'
  className: 'col-md-4 item'


class FollowerCollectionView extends marionette.CollectionView
  childView: FollowerItemView
  className: 'row'


class FollowerListLayout extends marionette.LayoutView
  template: require './templates/list/layout'
  className: 'follower_list_layout'
  regions:
    region_list: '.region_list'
    region_paginator: '.region_paginator'
    region_filter: '.region_filter'
  initialize: =>
    @collection = new FollowerCollection
    @list_view = new FollowerCollectionView
      collection: @collection

    @listenTo @list_view, 'childview:click', (view)=>
      backbone.history.navigate "/#{view.model.id}/", trigger: true
  onRender: =>
    @region_list.show(@list_view)
    @collection.fetch()

module.exports = FollowerListLayout