Set-PSReadlineOption -BellStyle None

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
            Write-OscSequence "133;D"
        }
        else {
            Write-OscSequence "133;D;$lec"
        }
    }

    # Emit FTCS_PROMPT (start of prompt) code.
    Write-OscSequence "133;A"
    # Emit current working diretory code: https://github.com/microsoft/terminal/issues/8166
    Write-OscSequence "9;9;`"$cwd`""

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
    Write-Host -NoNewline -ForegroundColor Green "$(Get-Date -Format "hh:mm:sstt") $('>' * ($nestedPromptLevel + 1))"

    $Global:__LastHistoryId = $LastHistoryEntry.Id

    # Emit FTCS_COMMAND_START (start of command line) code.
    Write-OscSequence "133;B"

    # Windows Terminal settings must include `"autoMarkPrompts": true,` to automatically emit
    # FCTS_COMMAND_EXECUTED (start of command output) code at the appropriate location.
    return " "
}

<#
    .SYNOPSIS
    Writes an ANSI escape code OSC (Operating System Code) sequence.

    .DESCRIPTION
    Writes an OSC sequence to the console. Does not write to the pipeline.

    .PARAMETER Code
    OSC sequence to write.

    .LINK
    ANSI Escape Codes: https://en.wikipedia.org/wiki/ANSI_escape_code

    .LINK
    Write-Host
#>
function Write-OscSequence {
    param(
        [Parameter(Mandatory, Position = 0)]
        [string] $Code
    )

    Write-Host -NoNewline "`e]$Code`a"
}

<#
    .SYNOPSIS
    Sets the terminal progress status.

    .DESCRIPTION
    Uses OSC sequence to set the progress of the current terminal window.

    Requires a compatible terminal such as Windows Terminal.

    .PARAMETER Clear
    Clear the current progress.

    .PARAMETER Indeterminate
    Sets the progress to indeterinate state.

    .PARAMETER Amount
    Sets the current progress amount as a number between 0 and 100.

    .PARAMETER Warning
    Sets the progress to warning state.

    .PARAMETER Error
    Sets the progress to error state.

    .LINK
    Related Windows Terminal Issue: https://github.com/microsoft/terminal/issues/6700

    .LINK
    Write-OscSequence
#>
function Set-Progress {
    param(
        [Parameter(ParameterSetName = "Clear")]
        [switch] $Clear,

        [Parameter(ParameterSetName = "Error")]
        [switch] $Error,

        [Parameter(ParameterSetName = "Indeterminate")]
        [switch] $Indeterminate,

        [Parameter(ParameterSetName = "Warning")]
        [switch] $Warning,

        [Parameter(ParameterSetName = "Amount", Position = 0)]
        [ValidateRange(0, 100)]
        [int] $Amount
    )

    if ($Clear) {
        Write-OscSequence "9;4;0"
    }
    elseif ($Error) {
        Write-OscSequence "9;4;2"
    }
    elseif ($Indeterminate) {
        Write-OscSequence "9;4;3"
    }
    elseif ($Warning) {
        Write-OscSequence "9;4;4"
    }
    else {
        $amt = [int]::Clamp($Amount, 0, 100)
        Write-OscSequence "9;4;1;$amt"
    }
}
