from json import loads, dumps


with open('processing.json') as config_file:
    config = loads(config_file.read())

config['commands-mandatory'].append(config['commands-to-decrease'][-1])
config['commands-to-decrease'] = config['commands-to-decrease'][0:-1]

with open('processing.json', 'w') as config_file:
    config_file.write(dumps(config, indent='\t'))
