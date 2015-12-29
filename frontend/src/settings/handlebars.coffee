moment = require 'moment'

handlebars = require 'hbsfy/runtime'
handlebars.registerHelper 'moment', (value, format) =>
  return moment(value).format(format)