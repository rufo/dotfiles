If ($PSVersionTable.PSVersion.Major -Le 5 -Or $isWindows) {
    If (-Not (Test-Path $env:LOCALAPPDATA\nvim)) {
        New-Item -Path $env:LOCALAPPDATA\nvim -ItemType Junction -Value $env:USERPROFILE\.config/nvim
    }
}
