# change variables
$gitURL = "URL"
$gitUsername = "Username"
$gitProjects = @("vmware_scripts","operational_scripts")

if(!(Test-Path -Path "${Env:UserProfile}\Projects")) {
    New-Item -Path "${Env:UserProfile}\Projects" -ItemType directory
}

Set-Location -Path "${Env:UserProfile}\Projects"

foreach($gitProject in $gitProjects) {
    $projectURL = $gitURL + $gitUsername + "/" + $gitProject + ".git"

    if(!(Test-Path -Path "${Env:UserProfile}\Projects\$gitProject")) {
        Write-Host "Cloning Project:" $gitProject
        git clone $projectURL
    }
}
