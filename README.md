SIEM Log Investigation — Windows Security Log Monitoring and Brute-Force Detection

Project Overview

This project uses PowerShell to analyze Windows Security Event Logs and identify patterns of repeated failed login attempts that may indicate brute-force activity.

Objectives

- Identify failed logon events (Windows Event ID 4625).
- Analyze failed login attempts for individual accounts.
- Detect five or more failed attempts within a five-minute window.
- Generate a CSV report containing possible brute-force alerts.

Technologies Used

- Windows 11
- PowerShell
- Windows Event Viewer
- CSV data processing

Project Files

- "Detect-BruteForce.ps1" — analyzes failed-logon data and detects suspicious patterns.
- "Test-Detect-BruteForce.ps1" — tests the detection logic using sample data.
- "TestFailedLogons.csv" — synthetic test data containing five failed-logon events.

Detection Logic

The script checks for five or more failed logon events associated with the same account within five minutes. When this threshold is reached, it reports possible brute-force activity and saves the alert information to "BruteForceAlerts.csv".

Testing and Results

Synthetic test data was used to verify that the detector identifies repeated failed login attempts and generates a CSV alert report.

The detector was also run against exported Windows Security logs. The available real log sample did not meet the configured detection threshold.

Limitations

This is a learning project. It analyzes exported CSV data and does not continuously monitor live security events. An alert indicates a suspicious pattern, not proof of a real attack.

Future Improvements

- Automate the collection of recent Windows Security events.
- Add scheduled monitoring and alert notifications.
- Detect suspicious activity across multiple accounts and IP addresses.
- Build a dashboard to visualize alerts.

Author

Computer Science Engineering Student
