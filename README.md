# dotconfig

## Install Software

The `install-software.ps1` script will install [Scoop](https://scoop.sh/), then
use Scoop to install the following software:
* [ConEmu](https://conemu.github.io/)
* [Git](https://git-scm.com/)
* OpenJDK 11 HotSpot ([AdopOpenJDK](https://adoptopenjdk.net/))
* [Maven](http://maven.apache.org/)
* [7-Zip](https://www.7-zip.org/)
* [Neovim](https://neovim.io/)
* [Vagrant](https://www.vagrantup.com/)
* [ripgrep](https://github.com/BurntSushi/ripgrep)
* [bat](https://github.com/sharkdp/bat)

Script execution must be enabled to run the installation script. Scoop also
requires script execution, so do not disable it after the installation is done.

```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
.\install-software.ps1
```

## Configuration Files
The following configuration files are provided.

| Application | File | Target Path |
|---|---|---|
| Git | `.gitconfig` | `~/.gitconfig` |
| Git | `.gitignore_global` | `~/.gitignore_global` |
| Neovim | `.vimrc` | `~/.config/nvim/init.vim` (Unix) <br> `~\AppData\Local\nvim\init.vim` (Windows) |
| Visual Studio Code | `vscode.settings.json` | `~\AppData\Roaming\Code\User\settings.json` (Windows) |
| PowerShell | `Profile.ps1` | `~\Documents\WindowsPowerShell\Profile.ps1` (Windows) |

### Symlinks
It is recommended that you create symlinks between configuration files in this
repository and their target path. This is so that all changes can be managed in
this repository without having to copy the files to their target path.

To do this, use the following command.
```powershell
New-Item -ItemType SymbolicLink -Path <LinkPath> -Value <SourceFile>
```

