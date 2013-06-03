game = new Game

window.onblur = -> game.stop()
window.onfocus = -> game.run()

game.run()
