game = new Game

window.onblur = -> game.stop()
window.onfocus = -> game.run()
$(window).on 'resize', => game.resize()

game.run()
