FootnoterView = require './footnoter-view'

module.exports =

  activate: (state) ->
    atom.commands.add "footnoter:multi-markdown", => @insert_multimarkdown()
    atom.commands.add "footnoter:html", => @insert_raw_html()

  insert_multimarkdown: ->
    # This assumes the active pane item is an editor
    editor = atom.workspace.getActivePaneItem()
    text_body = editor.getText()

    matches = text_body.match(/\[\^\d+\]/g) || []
    num = String(matches.length/2+1)

    index = "".concat('[^', num, ']')
    footnote = index.concat(': ')
    editor.insertText(index)
    editor.moveToBottom()()
    editor.insertNewline()
    editor.insertNewline()
    editor.moveToBottom()()

    editor.insertText(footnote)

  insert_raw_html: ->
    # This assumes the active pane item is an editor
    editor = atom.workspace.getActivePaneItem()
    text_body = editor.getText()

    matches = text_body.match(/<a name="(fn\d+)">/g) || []
    num = String(matches.length + 1)

    index = "".concat('<sup><a name="fni', num, '" href="#fn', num, '">', num, '</a></sup>')
    footnote_start = "".concat(num, '.<a name="fn', num, '">&nbsp;</a>')
    footnote_end = "".concat('<a href="#fni', num, '">&#8617;</a>')
    editor.insertText(index)
    editor.moveToBottom()()
    editor.insertNewline()
    editor.insertNewline()
    editor.moveToBottom()()

    editor.insertText(footnote_end)
    editor.moveToBeginningOfLine()
    editor.insertText(footnote_start)

  deactivate: ->


  serialize: ->
