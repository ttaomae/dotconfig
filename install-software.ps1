Invoke-WebRequest https://get.scoop.sh | Invoke-Expression

scoop bucket add extras
scoop bucket add java
scoop install `
    <# development #> `
    extras/conemu git java/adopt11-hotspot maven
    <# utilites #> `
    7zip neovim ripgrep vagrant bat
    <# admin #> `
    extras/rapidee

