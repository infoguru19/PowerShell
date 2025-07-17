$person= [PSCustomObject]@{                # person is Custom Object
    FirstName = "Ravi"                     # FirstName, LastName, etc are Properties of the object Person
    LastName = "Ranjan"
    Age = 32
    Occupaation = "DevOps Engineer"
}

$person.FirstName
$person.Occupaation

"My Full Name is $($person.FirstName) $($person.LastName)"
