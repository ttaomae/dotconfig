winget install --source winget --id Microsoft.PowerToys
winget install --source winget --id Microsoft.PowerShell
winget install --source winget --id Microsoft.WindowsTerminal

Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

scoop bucket add extras
scoop bucket add java
scoop bucket add ttaomae https://github.com/ttaomae/dotconfig

scoop install `
    <# development #> `
    git delta `
    <# Java #> `
    java/temurin-jdk maven java/visualvm java/jmc `
    <# utilites #> `
    neovim ripgrep vagrant bat less ttaomae/rut `
    <# utilities / admin #> `
    7zip extras/windirstat extras/sysinternals


