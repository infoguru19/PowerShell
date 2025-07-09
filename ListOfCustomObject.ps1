# List of Custom Object

$employee= @(
    [PSCustomObject]@{Name = "Alice"; Age = 32; Role = "Manger"}
    [PSCustomObject]@{Name = "John"; Age = 30; Role = "Developer"}
    [PSCustomObject]@{Name = "Rock"; Age = 31; Role = "Tester"}
)
"$($employee.Name)  $($employee.age)  $($employee.Role)"

# Iterate through list of Custom Object
foreach($i in $employee)
{
    "$($i.Name)  $($i.age)  $($i.Role)"
}

