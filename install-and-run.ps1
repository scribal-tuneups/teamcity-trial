# Let's make sure we can run this project
Set-ExecutionPolicy Bypass -Scope Process -Force

# Use a TLS 1.2 connection
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

# Install chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Get refreshenv
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

# Refresh environment
refreshenv

# Auto confirm
choco feature enable -n=allowGlobalConfirmation

# Install CMake
choco install cmake
refreshenv

# Install Visual Studio 2019 build tools
choco install visualstudio2019buildtools --notsilent --package-parameters "--includeRecommended --includeOptional"
refreshenv

# Install MSVC C++ Workloads
Write-Output "Install MSVC 2019 C++ workloads"
choco install visualstudio2019-workload-vctools --quiet --package-parameters "--add Microsoft.VisualStudio.Component.VC.ATLMFC --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64"
refreshenv

Write-Output "Install MSVC 2019 C++ Native Desktop workload"
choco install visualstudio2019-workload-nativedesktop
refreshenv

# Initialise the VC variables
"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\VC\\Auxiliary\\Build\\vcvars64.bat"

# Run CMake
mkdir build
cd build/
cmake ..
cmake --build .

# Where is everything?
Get-ChildItem -Path .

