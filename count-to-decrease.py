from json import loads


with open('processing.json') as config_file:
    config = loads(config_file.read())

print(len(config['commands-to-decrease']))
