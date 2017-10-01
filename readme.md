### Soulseek vnc service for docker

![Soulseek-logo](http://www.slsknet.org/news/sites/default/files/slsk_bird.jpg)

## Usage

Start [Soulseek](http://www.slsknet.org/) vnc server,  /Users/Music your sharing music map & /Users/Downloads your download map.

```
$ docker run \
    --name=soulseek \
    -v /Users/Music/:/home/soulseek/Music \
    -v /Users/Downloads:/home/soulseek/Downloads \
    -p 5900:5900 \
    -d \
    mendelgusmao/soulseek
```

and check:
```
$ docker logs soulseek
```

After this use a vnc client to connect (dockerhost:5900)
Everything should start automaticly, Click Ok, next next finish yes.

