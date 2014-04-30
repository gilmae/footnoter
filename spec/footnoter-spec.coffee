{WorkspaceView} = require 'atom'
Footnoter = require '../lib/footnoter'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Footnoter", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('footnoter')

  describe "when the footnoter:toggle event is triggered", ->
    it "there is no view, so no view is attached", ->
      expect(atom.workspaceView.find('.footnoter')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'footnoter:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.footnoter')).not.toExist()
        atom.workspaceView.trigger 'footnoter:toggle'
        expect(atom.workspaceView.find('.footnoter')).not.toExist()
