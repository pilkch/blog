---
author: Chris Pilkington
tags:
- dev
date: "2022-11-21T23:40:56Z"
id: 545
title: Replacing VSCode and VSCode Remote with VSCodium and Open Remote SSH
---

VSCode with the VSCode Remote plugin make for an awesome Windows client for connecting to a remote Linux machine to do the real development. It’s seamless, once connected to the remote it feels like you are just working on a Linux machine. In the background it connects via SSH to a Linux host, installs a server daemon, and from then on commands are handled by the VS Code Server plugin, from the client you can open files, edit them, create new terminals, navigate, install packages, build, all as if you are directly working on the remote. It’s like a hybrid of SSH and RDP.

![](/blog/wp-content/uploads/2022/11/image.png)

I love this combination. It’s how I develop at work and home. But, I don’t like the telemetry that Microsoft has added. They also seem to be [slowly closing up parts of VSCode in proprietary closed source extensions](https://github.com/VSCodium/vscodium/issues/196#issuecomment-940848704). Due to this worrying progression I started looking at VSCodium, but no VSCode Remote would be a deal breaker. Luckily there is the Open Remote SSH plugin.

### Download and Install VSCodium and Open Remote SSH plugin

1. Download and install [VSCodium](https://vscodium.com/)
2. Preferences: Open User Settings  
    Add this to settings.json:
    ```bash
    "terminal.integrated.shell.windows": "C:\windows\system32\cmd.exe"
    ```
3. Extensions  
    Search for jeanp413 and install the “Open Remote SSH” extension
4. Preferences: Configure Runtime Arguments  
    Add this at the end of the argv.json:
    ```bash
    "enable-proposed-api": [
    ...
    "jeanp413.open-remote-ssh",
    ]
    ```
5. Restart VSCodium
6. You should now be able to connect to a remote server under Remote Explorer on the left

If you were already using VSCode and VSCode Remote before this, then your remote hosts should all be listed under the new Open Remote SSH extension and they should all still work.
