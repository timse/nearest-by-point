# Karma configuration
# Generated on Thu Jan 16 2014 11:20:24 GMT+0100 (CET)

module.exports = (config) ->
  config.set

    # base path, that will be used to resolve all patterns, eg. files, exclude
    basePath: './'

    # frameworks to use
    frameworks: ['mocha']

    # list of files / patterns to load in the browser
    files: [
        'node_modules/chai/chai.js'
        'node_modules/sinon-chai/lib/sinon-chai.js'
        'node_modules/sinon/pkg/sinon.js'
        "node_modules/jquery/dist/jquery.js"


        "src/**/*.coffee"


        "test/**/*.coffee"
    ]

    # list of files to exclude
    exclude: [

    ]

    # test results reporter to use
    # possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
    reporters: ['progress']

    # web server port
    port: 9876

    # enable / disable colors in the output (reporters and logs)
    colors: true

    # level of logging
    # possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO

    # enable / disable watching file and executing tests whenever any file changes
    #autoWatch: true

    # Start these browsers, currently available:
    # - Chrome
    # - ChromeCanary
    # - Firefox
    # - Opera (has to be installed with `npm install karma-opera-launcher`)
    # - Safari (only Mac; has to be installed with `npm install karma-safari-launcher`)
    # - PhantomJS
    # - IE (only Windows; has to be installed with `npm install karma-ie-launcher`)
    browsers: ['Chrome', 'PhantomJS', 'Firefox', 'Safari']

    # preprocess coffee files
    preprocessors:
      'test/**/*.coffee': 'coffee'
      'src/**/*.coffee': 'coffee'
    coffeePreprocessor:
      options:
        bare: true
        sourceMap: true

    # If browser does not capture in given timeout [ms], kill it
    captureTimeout: 6000

    # Continuous Integration mode
    # if true, it capture browsers, run tests and exit
