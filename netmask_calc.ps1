#$prefix min. 16
$prefix = "23"

$netmask = "254"


if ([math]::pow(2,(32-$prefix))/256 -le 1) {
    $mask = 256-([math]::pow(2,(32-$prefix)))
    Write-Host "255.255.255.$mask"
} else {
    $mask = 256-([math]::pow(2,(32-$prefix))/256)
    Write-Host "255.255.$mask.0"
}

#256-([math]::pow(2,(32-$prefix))/65536)
#256-([math]::pow(2,(32-$prefix))/16777216)

if ((256-$netmask)%8 -eq 0) {
    $pre1 = 32-([math]::Log((256-$netmask))/[math]::log(2))
    $pre2 = $pre1-8
    Write-Host "/$pre1 or /$pre2"
} elseif ($netmask -eq 254) {
    Write-Host "/23"
} else {
    Write-Host "Not a correct Netmask"
}
