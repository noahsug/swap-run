game = new Game

atom.setDesiredSurfaceArea 500000

window.onblur = -> game.stop()
window.onfocus = -> game.run()
$(window).on 'resize', => game.resize()

game.run()
