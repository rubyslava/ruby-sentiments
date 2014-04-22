module.exports = (grunt) ->
  'use strict'

  require('load-grunt-tasks') grunt
  require('time-grunt') grunt
  path = require 'path'

  grunt.initConfig
    watch:
      options:
        livereload: true
        # spawn: false
      coffee:
        files: ['public/app/**/*.coffee']
        tasks: ['coffee:app', 'includeSource:app']
      compass:
        files: ['public/css/**/*.sass']
        tasks: ['compass:app']
      jade:
        files: ['public/app/**/*.jade']
        tasks: ['jade:app', 'html2js:app']

    coffee:
      options:
        bare: true
        sourceMap: true
        sourceRoot: ''
      app:
        files: [
          expand: true
          src: 'public/app/**/*.coffee'
          ext: '.js'
        ]

    compass:
      options:
        assetCacheBuster: false
        relativeAssets: true
        noLineComments: true
        outputStyle: 'compact'
      app:
        options:
          cssDir: 'public/css'
          sassDir: 'public/css'
          imagesDir: 'public/img'

    jade:
      options:
        pretty: true
      app:
        files: [
          expand: true
          src: "public/app/**/*.jade"
          ext: ".html"
        ]

    html2js:
      options:
        base: "public/app"
        module: "rs.templates"
        htmlmin:
          collapseBooleanAttributes     : true
          collapseWhitespace            : true
          removeAttributeQuotes         : false
          removeComments                : true
          removeEmptyAttributes         : false
          removeRedundantAttributes     : false
          removeScriptTypeAttributes    : true
          removeStyleLinkTypeAttributes : true
      app:
        src: 'public/app/**/*.html'
        dest: 'public/app/templates.js'

    includeSource:
      options:
        basePath: 'public'
      app:
        files:
          'public/index.html': 'public/index.tpl.html'


    express:
      dev:
        options:
          bases: path.resolve './src'
          port: 9000
          server: path.resolve './src/server'
          serverreload: true


  grunt.registerTask 'default', [
    'compass:app'
    'coffee:app'
    'jade:app'
    'html2js:app'
    'includeSource:app'
    'watch'
  ]


  grunt.registerTask 'server', (target) ->
    grunt.config 'watch.options.livereload', false
    grunt.task.run [
      'express:dev'
    ]


  return
