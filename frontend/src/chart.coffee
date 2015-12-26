$ = require 'jquery'
highcharts = require 'highcharts-browserify'
_ = require 'underscore'
marionette = require 'backbone.marionette'
moment = require 'moment'

class ChartView extends marionette.ItemView
  template: _.template '<div id="follower-chart"></div>'
  onRender: =>
    $.getJSON '/api/chart/', (response) ->
      data = _.map(response, (x) -> [moment(x['created']).valueOf(), x['value']])
      new highcharts.Chart
        title:
          text: 'Количество подписчиков'
        chart:
          renderTo: $('#follower-chart')[0]
          height: 400
        xAxis:
          type: 'datetime'
          labels:
              format: '{value:%d.%m}'
              rotation: -45
              align: 'right'
        yAxis:
          title:
            text: 'Количество подписчиков'
        series: [{
          type: 'area',
          name: 'Количество подписчиков',
          data: data
        }]

module.exports = ChartView