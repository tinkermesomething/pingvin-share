# <div align="center"><img  src="https://user-images.githubusercontent.com/58886915/166198400-c2134044-1198-4647-a8b6-da9c4a204c68.svg" width="40"/> </br>Tinkerme Share</div>

> **Note:** This is an actively maintained fork of [stonith404/pingvin-share](https://github.com/stonith404/pingvin-share), which was archived by the original author. This fork includes security updates, dependency upgrades, and ongoing maintenance. All credit for the original project goes to [stonith404](https://github.com/stonith404).

---

Tinkerme Share is a self-hosted file sharing platform and an alternative for WeTransfer.

## Features

- Share files using a link
- Unlimited file size (restricted only by disk space)
- Set an expiration date for shares
- Secure shares with visitor limits and passwords
- Email recipients
- Reverse shares
- OIDC and LDAP authentication
- Integration with ClamAV for security scans
- Different file providers: local storage and S3

## Get to know Tinkerme Share

- [Review by DB Tech](https://www.youtube.com/watch?v=rWwNeZCOPJA) (original Pingvin Share)

<img src="https://user-images.githubusercontent.com/58886915/225038319-b2ef742c-3a74-4eb6-9689-4207a36842a4.png" width="700"/>

## Setup

### Installation with Docker (recommended)

1. Download the `docker-compose.yml` file
2. Run `docker compose up -d`

The website is now listening on `http://localhost:3000`, have fun with Tinkerme Share!

> [!TIP]
> Checkout [Pocket ID](https://github.com/stonith404/pocket-id), a user-friendly OIDC provider that lets you easily log in to services like Tinkerme Share using Passkeys.

## Documentation

For more installation options and advanced configurations, please refer to the [documentation](https://tinkermesomething.github.io/tinkerme-share).

## Contribute

We would love it if you want to help make Tinkerme Share better! Check out our [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Credits

This project is a fork of [Pingvin Share](https://github.com/stonith404/pingvin-share) by [stonith404](https://github.com/stonith404). The original project was archived, and this fork continues development with security updates and new features.
