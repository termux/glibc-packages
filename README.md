# Glibc packages for termux - git repo mirror
![GitHub repo size](https://img.shields.io/github/repo-size/termux/glibc-packages)
![Gpkg last build status](https://github.com/termux/glibc-packages/workflows/Build%20gpkg/badge.svg)
![Repo last update status](https://github.com/termux/glibc-packages/workflows/Update%20repo/badge.svg)
[![Join the chat at https://gitter.im/termux/termux](https://badges.gitter.im/termux/termux.svg)](https://gitter.im/termux/termux)
[![Join the Termux discord server](https://img.shields.io/discord/641256914684084234.svg?label=&logo=discord&logoColor=ffffff&color=5865F2)](https://discord.gg/HXpF69X)

This is a mirror of the [termux-pacman/glibc-packages](https://github.com/termux-pacman/glibc-packages) repository in which packages are compiled in debian format and published to the Termux service.

To start using glibc packages, you need to install the `glibc-repo` package which will give you access to install them:
```
pkg install glibc-repo -y
```

After this, you can install the `glibc-runner` package - this command simplifies working with the glibc environment:
```
pkg install glibc-runner -y
```

Please note that due to the fact that this is a mirror, all actions described in [CONTRIBUTING.md](CONTRIBUTING.md) must be done in [termux-pacman/glibc-packages](https://github.com/termux-pacman/glibc-packages).
