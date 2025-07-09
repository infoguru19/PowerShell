$person= [PSCustomObject]@{
    FirstName = "Ravi"
    LastName = "Ranjan"
    Age = 32
    Occupaation = "DevOps Engineer"
}

$person.FirstName
$person.Occupaation

"My Full Name is $($person.FirstName) $($person.LastName)"