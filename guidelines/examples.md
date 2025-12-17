# =========================================
# Terraform Management Group Folder Creator
# With Guidelines Folder
# =========================================

$basePath = Get-Location

# Root folders
$root        = Join-Path $basePath "management-group-hierarchy"
$parent      = Join-Path $root "parent"
$modules     = Join-Path $root "modules"
$policies    = Join-Path $root "policies"
$guidelines  = Join-Path $root "guidelines"

# All folders to create
$folders = @(
    $root,
    $parent,
    $modules,
    "$modules\management_group",
    "$modules\policy_assignment",
    "$modules\rbac_assignment",
    "$modules\subscription_association",
    $policies,
    $guidelines
)

# Create folders
foreach ($folder in $folders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder | Out-Null
        Write-Host "Created folder: $folder"
    }
}

# Parent Terraform files
$parentFiles = @(
    "main.tf",
    "variables.tf",
    "outputs.tf",
    "terraform.tfvars"
)

foreach ($file in $parentFiles) {
    $filePath = Join-Path $parent $file
    if (-not (Test-Path $filePath)) {
        New-Item -ItemType File -Path $filePath | Out-Null
        Write-Host "Created file: $filePath"
    }
}

# Module files
$moduleFiles = @("main.tf", "variables.tf", "outputs.tf")
$moduleFolders = @(
    "$modules\management_group",
    "$modules\policy_assignment",
    "$modules\rbac_assignment",
    "$modules\subscription_association"
)

foreach ($module in $moduleFolders) {
    foreach ($file in $moduleFiles) {
        $filePath = Join-Path $module $file
        if (-not (Test-Path $filePath)) {
            New-Item -ItemType File -Path $filePath | Out-Null
            Write-Host "Created file: $filePath"
        }
    }
}

# Policy JSON files
$policyFiles = @(
    "tagging.json",
    "naming.json",
    "security_baseline.json",
    "identity_access.json"
)

foreach ($file in $policyFiles) {
    $filePath = Join-Path $policies $file
    if (-not (Test-Path $filePath)) {
        New-Item -ItemType File -Path $filePath | Out-Null
        Write-Host "Created policy file: $filePath"
    }
}

# Guidelines files
$guidelineFiles = @(
    "README.md",
    "examples.md"
)

foreach ($file in $guidelineFiles) {
    $filePath = Join-Path $guidelines $file
    if (-not (Test-Path $filePath)) {
        New-Item -ItemType File -Path $filePath | Out-Null
        Write-Host "Created guideline file: $filePath"
    }
}

Write-Host "`n✅ Terraform folder structure (with guidelines) created successfully!"
