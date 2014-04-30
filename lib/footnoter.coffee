FootnoterView = require './footnoter-view'

module.exports =

  activate: (state) ->
    atom.workspaceView.command "footnoter:multi-markdown", => @insert_multimarkdown()
    atom.workspaceView.command "footnoter:html", => @insert_raw_html()

  insert_multimarkdown: ->
    # This assumes the active pane item is an editor
    editor = atom.workspace.activePaneItem
    text_body = editor.getText()

    matches = text_body.match(/\[\^\d+\]/g) || []
    num = String(matches.length/2+1)

    index = "".concat('[^', num, ']')
    footnote = index.concat(': ')
    editor.insertText(index)
    editor.moveCursorToBottom()
    editor.insertNewline()
    editor.insertNewline()
    editor.moveCursorToBottom()

    editor.insertText(footnote)

  insert_raw_html: ->
    # This assumes the active pane item is an editor
    editor = atom.workspace.activePaneItem
    text_body = editor.getText()

    matches = text_body.match(/<a name="(fn\d+)">/g) || []
    num = String(matches.length + 1)

    index = "".concat('<sup><a name="fni', num, '" href="#fn', num, '">', num, '</a></sup>')
    footnote_start = "".concat('<a name="fn', num, '">', num, '. ')
    footnote_end = "".concat('</a> <a href="#fni', num, '">&#8617;</a>')
    editor.insertText(index)
    editor.moveCursorToBottom()
    editor.insertNewline()
    editor.insertNewline()
    editor.moveCursorToBottom()

    editor.insertText(footnote_end)
    editor.moveCursorToBeginningOfLine()
    editor.insertText(footnote_start)

  deactivate: ->


  serialize: ->
