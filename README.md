[![Build Status](https://travis-ci.org/axelspringer/confd.svg?branch=master)](https://travis-ci.org/axelspringer/confd) [![Docker Stars](https://img.shields.io/docker/stars/axelspringer/confd.svg)](https://hub.docker.com/r/axelspringer/confd/) [![Docker Pulls](https://img.shields.io/docker/pulls/axelspringer/confd.svg)](https://hub.docker.com/r/axelspringer/confd/)

# confd

Confd

https://github.com/kelseyhightower/confd

# use

> we use confd to contain ours configs in containers and publish them distributed

You can mount yours config in `/etc/confd` or overwrite the confd config.

[![](https://badge.imagelayers.io/axelspringer/confd.svg)](https://imagelayers.io/?images=axelspringer/confd)

```
# You can use 
docker run --rm --name confd axelspringer/confd
```

# License
[MIT](/LICENSE)