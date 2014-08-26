$ = require('../../vendor/zepto-browserify.js').Zepto
Handlebars = require('../../vendor/handlebars.min.js').Handlebars

Utils = require('./utils.coffee')
Translations = require('./translations.coffee')
IframeResizer = require('./iframe_resizer.coffee')

PodcastPanel = require('./podcast_panel.coffee')
ClientsPanel = require('./clients_panel.coffee')

class Popup
  constructor: (@podcast, @options) ->
    @render()
    @initPanels()

  render: () ->
    @elem = $(@template())
    $('body').append(@elem)
    @elem.find('#podlove-subscribe-popup-close-button').on 'click', () =>
      @elem.remove()

  template: Handlebars.compile('
    <div id="podlove-subscribe-popup" class="podlove-subscribe">
      <div id="podlove-subscribe-popup-modal">
        <div id="podlove-subscribe-popup-modal-inner" class="show-left">
          <span id="podlove-subscribe-popup-close-button" class="podlove-subscribe-install-button">&times;</span>

          <div id="podlove-subscribe-panel-podcast"></div>

          <div id="podlove-subscribe-panel-format"></div>

          <div id="podlove-subscribe-panel-type"></div>

          <div id="podlove-subscribe-panel-clients"></div>

          <div id="podlove-subscribe-panel-finish"></div>
        </div>
      </div>
    </div>
  ')

  initPanels: () ->
    prefix = '#podlove-subscribe-panel'
    @podcastPanel = new PodcastPanel(@elem.find("#{prefix}-podcast"), @)
    @clientsPanel = new ClientsPanel(@elem.find("#{prefix}-clients"), @)

  goToClients: () ->
    @podcastPanel.moveLeft('-100%')
    @clientsPanel.moveLeft('0%')

  goToPodcast: () ->
    @podcastPanel.moveRight('0%')
    @clientsPanel.moveRight('100%')

module.exports = Popup
