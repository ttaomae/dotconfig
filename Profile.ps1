Set-PSReadlineOption -BellStyle None

# Set-Location "set/preferred/default/location/here"

Set-Alias -Name vi  -Value nvim
Set-Alias -Name vim -Value nvim
Set-Alias -Name cat -Value bat -Option AllScope
Set-Alias -Name exp -Value explorer

# ctrl-d ==> exit PowerShell.
Set-PSReadlineKeyHandler -Chord ctrl+d -Function ViExit
# ctrl-w ==> delete word.
Set-PSReadlineKeyHandler -Chord ctrl+w -Function BackwardDeleteWord

function prompt() {
    $err = $?
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent() )

    if (!$err) {
        Write-Host -NoNewline -ForegroundColor Red 'ERROR '
    }

    if ($currentPrincipal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )) {
        Write-Host -NoNewline -ForegroundColor Magenta "admin"
    } else {
        Write-Host -NoNewline -ForegroundColor Cyan "$($env:username) "
    }

    Write-Host -ForegroundColor Cyan $(Get-Location)

    Write-Host -NoNewline -ForegroundColor Green $(Get-Date -Format "hh:mm:sstt") '>>'
    return ' '
}
