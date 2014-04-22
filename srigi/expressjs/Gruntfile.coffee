module.exports = (grunt) ->
  'use strict'

  require('load-grunt-tasks') grunt
  require('time-grunt') grunt
  path = require 'path'

  grunt.initConfig
    watch:
      options:
        livereload: true
      compass:
        files: ['public/css/**/*.sass']
        tasks: ['compass:dev']

    compass:
      options:
        assetCacheBuster: false
        relativeAssets: true
        noLineComments: true
        outputStyle: 'compact'
      dev:
        options:
          cssDir: 'public/css'
          sassDir: 'public/css'
          imagesDir: 'public/img'

    express:
      dev:
        options:
          bases: path.resolve './src'
          port: 9000
          server: path.resolve './src/server'
          serverreload: true


  grunt.registerTask 'default', [
    'compass'
    'express:dev'
    'watch'
  ]

  return
