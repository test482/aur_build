# aur build

Use Github Actions to build Arch packages.
For more information, please read [my post](https://viflythink.com/Use_GitHubActions_to_build_AUR/) (Chinese).

The uploadToOneDrive job is optional, you can use [urepo](https://github.com/vifly/urepo) to create your package repositorie after upload to OneDrive.

> fork from <https://github.com/vifly/arch-build>.

## usage

import gpg key first:

```bash
curl -L -o /tmp/eliot-repo.key https://github.com/test482/aur_build/raw/master/gpg-keys/arch-repo.key && sudo pacman-key --add /tmp/eliot-repo.key
sudo pacman-key --lsign-key eliotjoking@gmail.com
```

add repo conf to `/etc/pacman.conf`:

```conf
[eliot]
Server = https://archrepo.ecorp.one/
```

reflush pacman db data:

```bash
sudo pacman -Syy
```
