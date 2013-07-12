import os.path
import sys

ordered_game_files = [
  'util',
  'event_emitter',
  'position',

  'level',
  'graphic',
  'background_graphic',
  'entity_graphic',
  'entity_sprite_graphic',

  'factory',
  'graphic_factory',
  'sprite_builder',
  'simple_sprite_builder',

  'game_info',
  'keybindings',

  'move_behavior',
  'tracking_move_behavior',
  'user_input_move_behavior',

  'animation',

  'entity',
  'player',

  'entity_sprite_factory',
  'entity_factory',

  'enemy_spawner',
  'level_factory',
  'renderer',
  'game',
]
for i, file_name in enumerate(ordered_game_files):
  ordered_game_files[i] = '<script type=\"text/javascript" src="%s.js"></script>' % (file_name)

template = open('nodejs_web/index.html', 'r+')
html_content = template.read()
template.close()

game_files = []
if len(sys.argv) >= 2 and sys.argv[1] == "PROD":
  game_files = ordered_game_files
else:
  for coffee_file in os.listdir('coffee'):
    fileName = coffee_file[:-len('.coffee')]
    filePath = '<script type="text/javascript" src="%s.js"></script>' % (fileName)
    game_files.append(filePath)

js_content = '\n  '.join(game_files)
if len(sys.argv) >= 2 and sys.argv[1] == "DEV":
  js_content *= len(game_files)

html_content = html_content.replace('$GAME FILES$', js_content)
output = open('bin/index.html', 'w')
output.write(html_content)
output.close()
