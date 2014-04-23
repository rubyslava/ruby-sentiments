express      = require 'express'
fs           = require 'fs'

bodyParser   = require 'body-parser'
cookieParser = require 'cookie-parser'
errorhandler = require 'errorhandler'
logger       = require 'morgan'
session      = require 'express-session'
serveStatic  = require 'serve-static'


# Configure web server
app = express()
app.use logger('[:status] :method :url (:response-time ms)')
app.use bodyParser()
app.use cookieParser('some secret here')
app.use session()
app.use serveStatic('public')
app.use errorhandler() if app.get('env') == 'development'
app.set 'views', 'src/views'
app.set 'view engine', 'jade'


# Load Controllers
fs.readdirSync("#{__dirname}/controllers").forEach (file) ->
  require("#{__dirname}/controllers/#{file}")(app)


# Serve error404 when no middleware responded
app.use (req, res, next) ->
  res.status(404).render('404', { url: req.originalUrl })


# Export web server
module.exports = app
