$ = require 'jquery'
moment = require 'moment'
require 'moment-ru'
require 'config'
require 'bootstrap'
HighCharts = require 'highcharts-browserify'
_ = require 'underscore'

moment.locale 'ru'

Highcharts.setOptions
  lang:
    loading: 'Загрузка...'
    months: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь']
    weekdays: ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота']
    shortMonths: ['Янв', 'Фев', 'Март', 'Апр', 'Май', 'Июнь', 'Июль', 'Авг', 'Сент', 'Окт', 'Нояб', 'Дек']
    exportButtonTitle: "Экспорт"
    printButtonTitle: "Печать"
    rangeSelectorFrom: "С"
    rangeSelectorTo: "По"
    rangeSelectorZoom: "Период"
    downloadPNG: 'Скачать PNG'
    downloadJPEG: 'Скачать JPEG'
    downloadPDF: 'Скачать PDF'
    downloadSVG: 'Скачать SVG'
    printChart: 'Напечатать график'

$ ->
  $.getJSON '/api/follower/', (response) ->
    data = _.map(response, (x) -> [moment(x['created']).valueOf(), x['value']])
    console.log(data)
    new Highcharts.Chart
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