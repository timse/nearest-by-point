module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    meta:
      banner: """/*!
                  * <%= pkg.title || pkg.name %> - <%= pkg.description %>
                  * v<%= pkg.version %> - <%= grunt.template.today("UTC:yyyy-mm-dd h:MM:ss TT Z") %>
                  * Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author %>; Licensed <%= pkg.licenses %>
                  */

              """

    karma:
      options:
        client:
          mocha:
            bail:true
            timeout: 5000
        configFile: "karma.conf.coffee"
        singleRun: true
        reporters: 'dots'
      single:
        reporters: 'spec'
        singleRun: true
        browsers: ['Chrome', 'PhantomJS', 'Safari', 'Firefox']
      watch:
        singleRun: false
        browsers: ['Chrome']
      jenkins:
        reporters: 'spec'
        browsers: ['PhantomJS']
      safari:
        browsers: ['Safari']
      chrome:
        browsers: ['Chrome']
      firefox:
        browsers: ['Firefox']


    coffee:
      options:
        bare: true
      glob_to_multiple:
        expand: true,
        #flatten: true,
        cwd: 'src/',
        src: [
          '**/*.coffee'
        ],
        dest: 'src',
        ext: '.js'

    concat:
      options:
        stripBanners: true
        separator: ';'
        banner: "<%= meta.banner %> "
      dist:
        src:  [
          'static/before.txt'

          'src/*.js'

          'static/after.txt'
        ]
        dest: 'dist/<%= pkg.name %>.js'

    uglify:
      options:
        banner: "<%= meta.banner %>"
      dist:
        files:
          'dist/<%= pkg.name %>.min.js': ['<%= concat.dist.dest %>']

    watch:
      src:
        files: ['src/**/*.coffee', 'package.json']
        tasks: ['coffee']
      dist:
        files: ['src/**/*.coffee', 'package.json']
        tasks: ['dist']
      test:
        files: ['src/**/*.coffee', 'test/**/*.coffee']
        tasks: ['coffee', 'karma:watch:start']

    parallel:
      dev:
        options:
          grunt: true
          stream: true
        tasks: [
          'shell:serve'
          'watch:src'
          'watch:test'
        ]

    shell:
      serve:
        command: 'python -m SimpleHTTPServer 8081'
        options:
          stdout: true
          stderr: true

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-parallel'

  grunt.registerTask 'dist', [
                             'karma:single:start'
                             'coffee'
                             'concat:dist'
                             'uglify'
                             ]
  grunt.registerTask "dev", ['parallel:dev']
  grunt.registerTask "test", ['karma:single:start']
  grunt.registerTask "jenkins", [
                                'karma:jenkins:start'
                                'dist'
                                ]









