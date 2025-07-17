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

# To check "version" key Present or not
$Settings.ContainsKey("Vesrion")   # True as it present with Version : v2
foreach ($i in $Settings)
{
    $i          # Print Entire Dictionary
    $i.Keys     # Print Keys
    $i.Values   # Print Values
}
