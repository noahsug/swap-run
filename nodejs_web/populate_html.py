import os.path
import sys

template = open('nodejs_web/main.html', 'r+')
html_content = template.read()
template.close()

game_files = []
for coffee_file in os.listdir('coffee'):
  fileName = coffee_file[:-len('.coffee')]
  filePath = '<script type="text/javascript" src="%s.js"></script>' % (fileName)
  game_files.append(filePath)

js_content = '\n  '.join(game_files)
if len(sys.argv) >= 2 and sys.argv[1] == "DEV":
  js_content *= len(game_files)
html_content = html_content.replace('$GAME FILES$', js_content)

output = open('bin/main.html', 'w')
output.write(html_content)
output.close()
