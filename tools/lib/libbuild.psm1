function Invoke-CargoPackageBuild {
    param(
        [string]$name
    )
    Set-Location "${PSScriptRoot}\..\..";
    $ROOT = Get-Location;

    Write-Host -ForegroundColor Yellow "Building $name";
    Set-Location "${ROOT}/core/$name";
    cargo build --release;
    if (!(Test-Path "${ROOT}/bin")) { New-Item -ItemType Directory -Path "${ROOT}/bin" }
    if($IsLinux) {
        Copy-Item "${PWD}/target/release/${name}" "${ROOT}/bin/";
    } else {
        Copy-Item "${PWD}/target/release/${name}.exe" "${ROOT}/bin/";
    }
}