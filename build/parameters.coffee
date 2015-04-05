replacer = (replacePlugin, placeholder, target) ->
  replacePlugin new RegExp(placeholder, 'g'), target

bowerModule = require '../bower.json'
moduleName = bowerModule.name
modulePlaceholder = '%module%'

srcPath = 'src'
assetsPlaceholder = '%assets%'
assetsFolder = 'common/assets'
assetsPath = "#{srcPath}/#{assetsFolder}"

wwwPath = 'www'
scriptsPlaceholder = '%scripts%'
scriptsFolder = 'js'
scriptsPath = "#{wwwPath}/#{scriptsFolder}"
stylesPlaceholder = '%styles%'
stylesFolder = 'css'
stylesPath = "#{wwwPath}/#{stylesFolder}"

config =
  env: process.env.NODE_ENV || "dev"

  paths:
    src:
      main: srcPath
      assets: assetsPath
      i18n: 'i18n'
      libs: 'libs'
      bower: 'bower_components'
    www:
      main: wwwPath
      scripts: scriptsPath
      styles: stylesPath

  folders:
    scripts:
      name: scriptsFolder
      replacer: (replace) -> replace scriptsPlaceholder, scriptsFolder
    styles:
      name: stylesFolder
      replacer: (replace) -> replace stylesPlaceholder, stylesFolder

  files:
    app: "#{moduleName}.js"
    styles: "#{moduleName}.css"
    templates: 'templates.js'
    configuration: 'config.json'
    vendors:
      scripts: 'vendor.js'
      styles: 'vendor.css'

  angular:
    module:
      name: moduleName
      placeholder: modulePlaceholder
      # Include the replace in the streams where needed
      replacer: (replace) -> replace modulePlaceholder, moduleName

module.exports = config
