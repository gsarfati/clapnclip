angular.module 'starter.translate', ['pascalprecht.translate']

.config ($translateProvider) ->

  $translateProvider.useStaticFilesLoader
    prefix: 'i18n/locale-'
    suffix: '.json'

  $translateProvider.determinePreferredLanguage ->
    availables = ['en', 'fr'] # Add languages here
    nav = window.navigator
    lang = nav.language or nav.browserLanguage or
      nav.systemLanguage or nav.userLanguage
    if lang
      lang = lang.split('-')[0]
      if lang not in availables
        lang = undefined
    if not lang
      lang = availables[0]
    return lang

  $translateProvider.fallbackLanguage 'en'

  return
