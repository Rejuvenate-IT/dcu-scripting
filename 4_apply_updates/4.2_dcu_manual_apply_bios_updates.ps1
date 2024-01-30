#script to install only bios updates --> need to check bios permission stuff before this specific ones get 
if (Test-Path $dcuCliPath -PathType Leaf) {
    Write-Host "Dell Command Update CLI found. Scanning for BIOS update..." -ForegroundColor Green

    # Run a BIOS update scan
    $scanResult = Start-Process -FilePath $dcuCliPath -ArgumentList '/scan -updateType=bios -autoSuspendBitLocker=enable' -Wait -PassThru

    if ($scanResult.ExitCode -eq 1) {
        Write-Host "BIOS update found. Applying BIOS update..." -ForegroundColor Green

        # Apply BIOS update without reboot
        Start-Process -FilePath $dcuCliPath -ArgumentList "/applyUpdates -updateType=bios -reboot=disable -outputlog=C:\Users\$env:username\Desktop\dcuUpdateLog.log" -Wait

        Write-Host "BIOS update applied successfully." -ForegroundColor Green
    } else {
        Write-Host "No BIOS update found." -ForegroundColor Yellow
    }
} else {
    Write-Host "Error: Dell Command Update CLI (dcu-cli.exe) not found at $dcuCliPath." -ForegroundColor Red
}
