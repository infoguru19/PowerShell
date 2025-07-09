# Error Handling: Try Catch Finally

try {
    Get-Content -Path "C:/NonExistingFile.txt" -ErrorAction Stop
}
catch {
    Write-Output("Error: $($_.Exception.Message)")
    Get-Content -Path "C:\Users\ravic\Downloads\hello.txt"
}
finally {
    Write-Output ("File Operation Closed")
}