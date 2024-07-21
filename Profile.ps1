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

$Global:__LastHistoryId = -1

# Copied from Windows Terminal Shell Integration docs.
# https://learn.microsoft.com/en-us/windows/terminal/tutorials/shell-integration
function Global:__Terminal-Get-LastExitCode {
    if ($? -eq $True) {
        return 0
    }

    $LastHistoryEntry = $(Get-History -Count 1)
    $IsPowerShellError = $Error[0].InvocationInfo.HistoryId -eq $LastHistoryEntry.Id
    if ($IsPowerShellError) {
        return -1
    }

    return $LASTEXITCODE
}

# Adapted from shell integration docs.
function prompt {
    # This must be the first command in this function. Otherwise it will return the result of the
    # most recent command in the function rather than the prompt command.
    $lec = $(__Terminal-Get-LastExitCode);

    # `Get-Location` on its own behaves poorly with the current working directory code
    # (see "`e]9;9;...`a" below) when the path is on a network share.
    $cwd = (Get-Location).ProviderPath

    # Set window title to include the current directory name.
    $Host.UI.RawUI.WindowTitle = "PWSH > $($cwd | Split-Path -Leaf)"

    $LastHistoryEntry = $(Get-History -Count 1)
    # Emit FTCS_COMMAND_FINISHED (end of command) code, but skip if this is the first command.
    if ($Global:__LastHistoryId -ne -1) {
        # Do not include exit code if there was no new command.
        # This can happen, for example, when pressing ctrl+c or enter on an empty command.
        if ($LastHistoryEntry.Id -eq $Global:__LastHistoryId) {
            Write-Host -NoNewLine "`e]133;D`a"
        }
        else {
            Write-Host -NoNewLine "`e]133;D;$lec`a"
        }
    }

    # Emit FTCS_PROMPT (start of prompt) code.
    Write-Host -NoNewLine "`e]133;A`a"
    # Emit current working diretory code: https://github.com/microsoft/terminal/issues/8166
    Write-Host -NoNewLine "`e]9;9;`"$cwd`"`a"

    # Display exit code in case of error.
    if ($lec -ne 0) {
        Write-Host -NoNewline -ForegroundColor Red "[ERROR $lec] "
    }

    # Display username and include "/admin" suffix if applicable.
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent() )
    if ($currentPrincipal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )) {
        Write-Host -NoNewline -ForegroundColor Magenta "$($env:username)/admin "
    } else {
        Write-Host -NoNewline -ForegroundColor Cyan "$($env:username) "
    }

    # Display current directory. Include new line so that the date prompt is on the next line.
    # This keeps the prompt where the command is entered short and consistently sized.
    Write-Host -ForegroundColor Cyan $cwd
    Write-Host -NoNewline -ForegroundColor Green "$(Get-Date -Format "hh:mm:sstt") $('>' * ($nestedPromptLevel + 1)) "

    $Global:__LastHistoryId = $LastHistoryEntry.Id

    # Emit FTCS_COMMAND_START (start of command line) code.
    return "`e]133;B`a"
    # Windows Terminal settings must include `"autoMarkPrompts": true,` to automatically emit
    # FCTS_COMMAND_EXECUTED (start of command output) code at the appropriate location.
}
