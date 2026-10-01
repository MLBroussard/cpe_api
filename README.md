# Vulnerability Assessment

PowerShell-based vulnerability assessment and reporting workflow using the
NIST National Vulnerability Database (NVD).

## Current Features

- CSV-based software inventory
- NVD CVE API 2.0 integration
- Published CVE monitoring
- Modified CVE monitoring
- Incremental assessment using persistent state
- Assessment-window overlap
- Long assessment-window chunking
- NVD pagination
- Anonymous API rate-limit handling
- Retry handling
- CPE application matching
- Installed-version applicability checking
- CVSS extraction
- Persistent vulnerability finding history
- OPEN finding tracking
- Automatic remediation detection
- RESOLVED finding tracking
- Regression/reopening detection
- Excel vulnerability reporting
- Automated assessment tests

## Requirements

- Windows PowerShell 5.1
- Internet access to the NVD API
- TLS 1.2
- ImportExcel module

A packaged version of ImportExcel is included under:

    Modules/ImportExcel/

Microsoft Excel is not required to generate the report.

## Project Structure

    cve_api/
    ├── Invoke-DailyVulnerabilityAssessment.ps1
    ├── New-VulnerabilityReport.ps1
    ├── Test-VulnerabilityAssessment.ps1
    ├── Inventory.csv
    ├── README.md
    ├── .gitignore
    ├── Modules/
    │   └── ImportExcel/
    ├── State/
    ├── Results/
    └── Reports/

## Inventory

Inventory.csv contains the software installations that should be assessed.

Required columns:

    Name
    Vendor
    Product
    CPEProduct
    Version

Example:

    Name,Vendor,Product,CPEProduct,Version
    FILEBEAT01,elastic,Filebeat,filebeat,9.1.2

## Run an Assessment

From Windows PowerShell 5.1:

    .\Invoke-DailyVulnerabilityAssessment.ps1

The assessment queries the NVD for newly published and modified CVEs and
compares them with the configured inventory.

## Generate the Excel Report

Run:

    .\New-VulnerabilityReport.ps1

The report is generated under:

    Reports/VulnerabilityReport.xlsx

## Run Tests

Run:

    .\Test-VulnerabilityAssessment.ps1

Tests are executed against temporary copies of the project data so the
production inventory, state, and finding history are not intentionally
modified.

## Finding Lifecycle

A finding is created when an installed product/version is determined to be
affected by an NVD CVE.

Finding states:

- OPEN
- RESOLVED

If a previously resolved vulnerability becomes applicable again, a new OPEN
finding is created while the previous resolved record is retained.

## Runtime Files

The following files are generated locally and are not intended to be stored
in Git:

    State/LastRun.json
    Results/Findings.csv
    Reports/VulnerabilityReport.xlsx

## Planned Enhancements

- Nessus historical CPE import
- Organizational CPE catalog
- Improved CPE configuration evaluation
- Expanded software version handling
- Workflow logging
- Exit-code handling
- Task Scheduler integration
- Automated inventory generation
