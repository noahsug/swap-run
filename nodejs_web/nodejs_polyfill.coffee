# Mocks node.js methods so that code run on node.js can also run in the browser

window.require = ->
  window

window.exports = window
