# Dist

The `dist` folder contains sample configs for various platforms.

## Assumptions

The examples assume you will either be using replicators default settings or that you will be writing your configuration file(s) within `/etc/replicator.d` on the filesystem.

## Upstart

On systems using [upstart](http://upstart.ubuntu.com/), the [upstart configuration file](https://github.com/glympse/replicator/blob/master/dist/upstart/replicator.conf) can be used to control the replicator binary. It should be placed under `/etc/init/replicator.conf`. This will then allow you to control the daemon through `start|stop|restart` commands.

## Systemd

On systems using [systemd](https://www.freedesktop.org/wiki/Software/systemd/), the [basic systemd unit file](https://github.com/glympse/replicator/blob/master/dist/systemd/replicator.service) can be usd to control the replicator daemon and should be placed under `/etc/systemd/system/replicator.service`. This then allows you to control the daemon through `start|stop|restart` commands.
