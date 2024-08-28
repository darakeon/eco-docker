from json import loads
from sys import argv


with open('processing.json') as config_file:
    config = loads(config_file.read())

if len(argv) > 1:
    last_dep = int(argv[1])
else:
    last_dep = len(config['commands-to-decrease'])


dockerfile_content = []

dockerfile_content.append(f'FROM {config["image"]}')

dockerfile_content.append('')
dockerfile_content.append(f'COPY files-to-copy/ .')

dockerfile_content.append('')
for command in config['commands-mandatory']:
    dockerfile_content.append(f'RUN {command}')

dockerfile_content.append(f'')
for command in config['commands-to-decrease'][0:last_dep]:
    dockerfile_content.append(f'RUN {command}')

dockerfile_content.append(f'')
for command in config['commands-to-test']:
    dockerfile_content.append(f'RUN {command}')

for line in range(0, len(dockerfile_content)):
    dockerfile_content[line] = f'{dockerfile_content[line]}\n'

with open('Dockerfile', 'w') as dockerfile_file:
    dockerfile_file.writelines(dockerfile_content)
