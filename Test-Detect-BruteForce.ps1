$csvPath = "$env:USERPROFILE\Desktop\TestFailedLogons.csv"

$events = Import-Csv $csvPath |
    ForEach-Object {
        [PSCustomObject]@{
            TimeCreated = [datetime]$_.TimeCreated
            AccountName = $_.AccountName
            EventID     = [int]$_.EventID
        }
    } |
    Where-Object { $_.EventID -eq 4625 }

$windowMinutes = 5
$threshold = 5
$alerts = @()

foreach ($event in $events) {
    $start = $event.TimeCreated.AddMinutes(-$windowMinutes)

    $matches = @($events | Where-Object {
        $_.AccountName -eq $event.AccountName -and
        $_.TimeCreated -ge $start -and
        $_.TimeCreated -le $event.TimeCreated
    })

    if ($matches.Count -ge $threshold) {
        $alerts += [PSCustomObject]@{
            AccountName       = $event.AccountName
            FailedAttempts    = $matches.Count
            WindowMinutes     = $windowMinutes
            Detection         = "Possible brute-force activity"
            TimeDetected      = $event.TimeCreated
        }
    }
}

if ($alerts.Count -gt 0) {
    $reportPath = "$env:USERPROFILE\Desktop\BruteForceAlerts.csv"

    $alerts | Sort-Object TimeDetected -Unique |
        Export-Csv -Path $reportPath -NoTypeInformation

    Write-Host "Possible brute-force activity detected."
    Write-Host "Alert report saved to: $reportPath"
} else {
    Write-Host "No brute-force pattern detected in the available logs."
}