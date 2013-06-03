import os.path

template = open('nodejs_web/main.html', 'r+')
content = template.read()
template.close()

game_files = []
for coffee_file in os.listdir('coffee'):
  fileName = coffee_file[:-len('.coffee')]
  filePath = '<script type="text/javascript" src="%s.js"></script>' % (fileName)
  game_files.append(filePath)

content = content.replace('$GAME FILES$', '\n'.join(game_files)*2)

output = open('bin/main.html', 'w')
output.write(content)
output.close()
