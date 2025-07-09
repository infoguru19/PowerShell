# if elseif else - Conditional Statement
$age = 19
if ( $age -lt 18) {
    Write-Output ("You are Minor")
}
elseif ($age -ge 18 -and $age -le 60) {
    Write-Output ("You are Adult")
}
else {
    Write-Output ("You are Senior Citizen")
}