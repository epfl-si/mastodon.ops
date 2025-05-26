# Mastodon@EPFL (aka social.epfl.ch)

<p align="center" width="100%">
  <img src="media/Mastodon@EPFL.png" alt="Mastodon@EPFL logo" />
  <br>This repository hold the code to deploy EPFL's Mastodon server with Ansible.
  It can be accessed at https://social.epfl.ch.
</p>


## About

Since February 2025, EPFL host its own instance of Mastodon on
https://social.epfl.ch.

[Mastodon] is an open source, self-hosted, social networking service. Mastodon
uses the [ActivityPub] protocol for federation which allows users to communicate
between independent Mastodon instances and other ActivityPub compatible
services. Mastodon has microblogging features similar to Twitter, and is
generally considered to be a part of the [Fediverse]. (Read more on [wikipedia])


## Bird's view

This repo uses [Ansible] with a wrapper that install it locally called
[Ansible suitcase]. The Mastodon blocks are deployed with Docker on the
remote hosts, following the official Docker deployment method[^1]. It results
of the deployment of 5 containers (`mastodon-web`, `mastodon-postgresql`,
`mastodon-redis`, `mastodon-sidekiq` and `mastodon-streaming`). Containers
`prometheus`, `node-exporter` and `alertmanager` ensure some basic observability
and alerting. On top of that, the `traefik` containers deals with all HTTP
requests and offers the [Let's Encrypt] TLS certificate to users.


[^1]: https://github.com/mastodon/mastodon/blob/main/docker-compose.yml


## Usage

```sh
./mastodonsible
```

By default this will deploy on the test inventory. Use `--prod` to use the
production inventory. If needed, you can use `--protect` to add a basic
authentication middlewar in the Traefik setup.

> [!NOTE]  
> Due to the instrumentation of the Mastodon metrics inside the Mastodon
> image, you will have to *push* an updated version of
> [mastodon-web/Dockerfile](docker/mastodon-web/Dockerfile) with
> the correct Mastodon version that will be cloned and built on the target.
> Version has to be changed in [vars/versions.yml](vars/versions.yml) too.

[EPFL]: https://www.epfl.ch
[mastodon]: https://joinmastodon.org
[activitypub]: https://activitypub.rocks/
[fediverse]: https://en.wikipedia.org/wiki/Fediverse
[wikipedia]: https://en.wikipedia.org/wiki/Mastodon_(social_network)

[Ansible]: https://ansible.com
[Ansible suitcase]: https://github.com/epfl-si/ansible.suitcase
[Let's Encrypt]: https://letsencrypt.org/

<a rel="me" href="https://social.epfl.ch/@epfladmin"> </a>
<meta name="fediverse:creator" content="@epfladmin@social.epfl.ch">
