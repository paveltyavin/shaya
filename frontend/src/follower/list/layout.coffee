$ = require 'jquery'
_ = require 'underscore'

backbone = require 'backbone'
marionette = require 'backbone.marionette'
modelbinder = require 'backbone.modelbinder'
moment = require 'moment'
require 'jquery.scrolling'

class FilterModel extends backbone.Model
  defaults:
    page: 1
    page_size: 24
    is_active: ''

class Follower extends backbone.Model

class Collection extends backbone.Collection
  url: '/api/follower/'
  parse: (response) =>
    @count = response.count
    return response.results


class ItemView extends marionette.ItemView
  template: require './templates/item'
  triggers:
    'click': 'click'
  className: 'col-md-2 item'


class FilterView extends marionette.ItemView
  template: require './templates/filter'
  onBeforeDestroy: =>
    @binder.unbind()
  initialize: =>
    @binder = new modelbinder
  onRender: =>
    @binder.bind @model, @$el,
      is_active: '[name=is_active]'


class CollectionView extends marionette.CollectionView
  childView: ItemView
  className: 'row'


class Layout extends marionette.LayoutView
  template: require './templates/layout'
  className: 'follower_list_layout'
  progress: true
  regions:
    region_list: '.region_list'
    region_filter: '.region_filter'

  doFilter: =>
    @progress = true
    @collection.fetch
      data: @filter_model.toJSON()
    .done =>
      @progress = false
  initialize: =>
    @collection = new Collection
    @list_view = new CollectionView
      collection: @collection
    @filter_model = new FilterModel
    @filter_view = new FilterView
      model: @filter_model

    @listenTo @list_view, 'childview:click', (view)=>
      backbone.history.navigate "/follower/#{view.model.id}/", trigger: true

    @listenTo @filter_model, 'change', @doFilter
  onRender: =>
    @region_list.show(@list_view)
    @region_filter.show(@filter_view)
    @doFilter()

  onShow: =>
    @$('#scrolling_marker').scrolling()
    @$('#scrolling_marker').on 'scrollin', =>
      if @progress
        return
      count = @collection.count
      if !count
        return
      page = @filter_model.get 'page'
      page_size = @filter_model.get 'page_size'
      if page_size * (page + 1) > count
        return
      @filter_model.set 'page_size', page_size + 24

module.exports = Layout