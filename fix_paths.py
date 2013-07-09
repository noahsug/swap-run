import os.path

file = open('graphic_factory.js', 'r')
content = f.read()
file.close()

content = content.replace('"../assets/" + ', '')
file = open('graphic_factory.js', 'w')
file.write(content)
file.close()
