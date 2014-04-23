angular.module('rs.shared')

.factory 'random', ->
  return (len = 7) ->
    out = []
    pool = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'

    while len
      out.push(pool.charAt(Math.floor(Math.random() * pool.length)))
      len--

    return out.join('')
