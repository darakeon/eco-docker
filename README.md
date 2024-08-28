# Eco Docker

- Change the file config.json to reflect the format of your dockerfile (the one versioned is an example):
    - image: name of the origin image
    - commands-mandatory: the commands you already know that are mandatory;
    - commands-to-decrease: the commands you are not sure if are mandatory or not;
    - commands-to-test: the commands that are dependending on previous commands to see if it works or not.
- Add any necessary files into the "files-to-copy" folder;
- Run the command:

```
./eco-docker.sh
```

After running that, the last Dockerfile created is the one with only mandatory stuff. You can check the file results.json too, it will have the reduced version of the config.json file. 
