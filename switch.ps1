# Switch - For Multiple Condition

$input1 = "green"

switch ($input1) {
    "Red" { Write-Output "Stop" }
    "Green" {Write-Output "Go"}
    "Yellow" {Write-Output "Caution!"}
    Default { Write-Output "Unknown Color"}
}