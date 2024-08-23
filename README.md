# Mastodon Ops

This repository hold the code to deploy the Mastodon server of EPFL.

## How to Use

- Run the configuration-as-code
- [Work-in-progress] Add the following line to the `/etc/hosts` of **both** your workstation **and** the VM you install to:
  ```
  127.0.0.1	mastodon-test.fsd.team
  ```
- ssh to the VM with dynamic SOCKS forwarding on, e.g.
  ```
  ssh -D 3333 root@86.119.28.138
  ```
- Run the following commands (which obviously should be moved into the configuration-as-code at some point):
  ```
  cd /srv/mastodon
  docker compose run --rm web bundle exec rake db:migrate db:seed
  ```
- Install the FoxyProxy browser extension
- Create a FoxyProxy profile configured thusly:
  - name: SOCKS (or whatever you prefer, really)
  - Type: SOCKS5
  - Hostname: localhost
  - Port: 3333
  - DNS proxy: yes
- Activate the FoxyProxy profile you just set up
- Visit https://whatismyipaddress.com/ to validate that your browser is now browsing from 86.119.28.138
- Browse https://mastodon-test.fsd.team/explore
