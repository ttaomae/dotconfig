Set-PSReadlineOption -BellStyle None

# Set-Location "set/preferred/location/here"

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
