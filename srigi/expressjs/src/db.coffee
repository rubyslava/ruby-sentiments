Bookshelf = require 'bookshelf'


# Configure database connection
module.exports = Bookshelf.initialize {
  client: 'pg'
  connection: {
    charset  : 'utf8'
    host     : 'localhost'
    database : 'ruby-sentiments'
    user     : 'srigi'
    password : ''
  }
}
