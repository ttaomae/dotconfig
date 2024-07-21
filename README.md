# dotconfig

## Install Software

The `install-software.ps1` script will install the following software:

* Development
    * [PowerShell](https://learn.microsoft.com/en-us/powershell/)
    * [Windows Terminal](https://learn.microsoft.com/en-us/windows/terminal/)
    * [Git](https://git-scm.com/)
        * [Delta](https://dandavison.github.io/delta/)
    * Java
        * JDK ([Eclipse Temurin](https://adoptium.net/temurin/releases/))
        * [Maven](https://maven.apache.org/)
        * [VisualVM](https://visualvm.github.io/)
        * [JDK Mission Control](https://openjdk.org/projects/jmc/)
* Command Line Tools
    * [Neovim](https://neovim.io/)
    * [ripgrep](https://github.com/BurntSushi/ripgrep)
    * [Vagrant](https://www.vagrantup.com/)
    * [bat](https://github.com/sharkdp/bat)
    * [less](https://www.greenwoodsoftware.com/less/)
    * [rut](https://github.com/ttaomae/rut)
* Utilities / System Administration
    * [PowerToys](https://learn.microsoft.com/en-us/windows/powertoys/)
    * [7-Zip](https://www.7-zip.org/)
    * [WinDirStat](https://windirstat.net/)
    * [Sysinternals](https://learn.microsoft.com/en-us/sysinternals/)

various a collection of software.[Scoop](https://scoop.sh/), then
use Scoop to install the following software:

Script execution must be enabled to run the installation script. Additionally,
many of the software are installed and managed by [Scoop](https://scoop.sh/)
which also requires script execution, so do not disable it after the
installation is complete.

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
.\install-software.ps1
```

## Scoop Bucket
This repository is also a Scoop [bucket](https://github.com/lukesampson/scoop/wiki/Buckets).
The `install-software.ps1` script automatically adds it with the name `ttaomae`.

## Configuration Files
The following configuration files are provided.

| Application | File / Folder | Target Path |
|---|---|---|
| Git | `.gitconfig` | `~/.gitconfig` |
| Git | `.gitignore_global` | `~/.gitignore_global` |
| Neovim | `nvim/` | `~/.config/nvim/` (Unix) <br> `~\AppData\Local\nvim\` (Windows) |
| Visual Studio Code | `vscode.settings.json` | `~\AppData\Roaming\Code\User\settings.json` (Windows) |
| PowerShell | `Profile.ps1` | `~\Documents\WindowsPowerShell\Profile.ps1` (Windows) |
| PowerShell Core | `Profile.ps1` | `~\Documents\PowerShell\Profile.ps1` (Windows) |

### Symlinks
It is recommended that you create symlinks between configuration files in this
repository and their target path. This is so that all changes can be managed in
this repository without having to copy the files to their target path.

To do this, use the following command.
```powershell
New-Item -ItemType SymbolicLink -Path <LinkPath> -Value <SourceFile>
```

