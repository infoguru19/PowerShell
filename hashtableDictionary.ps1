# Duplicate value not Allowed
# Not Case Sensitive

$Settings = @{
    "AppName" = "App1"
    "Version" = "v1"
    "User" = 100
}

$Settings["appname", "Version"]  # Not Case Sensitive

$Settings["version"] = "v2"     # Change Value
$Settings["version"]

$Settings.ContainsKey("Vesrion")  # To check vesion Preent or not

foreach ($i in $Settings)
{
    $i          # Print Entire Dictionary
    $i.Keys     # Print Keys
    $i.Values   # Print Values
}