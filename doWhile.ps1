# Do-while - Loop that execute a block of code at least once
# then, Continue executing the block untill condition is true

$count = 0

do {
    Write-Output $count
    $count++
} while (
    $count -le 5
)