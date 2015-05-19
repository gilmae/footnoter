{View} = require 'atom-space-pen-views'

module.exports =
class FootnoterView extends View
  @content: ->

  initialize: (serializeState) ->
    atom.workspaceView.command "footnoter:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "FootnoterView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
