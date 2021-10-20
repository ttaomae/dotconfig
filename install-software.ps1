Invoke-WebRequest https://get.scoop.sh | Invoke-Expression

scoop bucket add extras
scoop bucket add java
scoop bucket add ttaomae https://github.com/ttaomae/dotconfig

scoop install `
    <# development #> `
    git delta `
    <# Java #> `
    java/openjdk maven ttaomae/visualvm jmc `
    <# utilites #> `
    7zip neovim ripgrep vagrant bat less `
    <# admin #> `
    extras/rapidee extras/windirstat extras/sysinternals

