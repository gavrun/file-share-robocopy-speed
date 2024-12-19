$sourcePath = "C:\source"
$destinationPath = "C:\destination"
$start = Get-Date
$robocopyProcess = Start-Process -FilePath "robocopy" -ArgumentList "$sourcePath `"$destinationPath`" /MIR /J /XJ" -NoNewWindow -PassThru
Start-Sleep -Seconds 5
$robocopyProcess | Stop-Process
$end = Get-Date
$elapsed = $end - $start
$totalSeconds = [math]::Round($elapsed.TotalSeconds, 2)
Write-Output ""
Write-Output "Start time: $start"
Write-Output "End time: $end"
Write-Output "Elapsed time: $elapsed"
$totalBytesCopied = (Get-ChildItem $destinationPath -File -Recurse | Measure-Object -Property Length -Sum).Sum
$totalMBCopied = [math]::Round($totalBytesCopied / 1MB, 2)
$transferRateMBps = [math]::Round($totalMBCopied / $elapsed.TotalSeconds, 2)
Write-Output "Total data copied: $totalMBCopied MB"
Write-Output "Elapsed time: $totalSeconds seconds"
Write-Output "Transfer rate: $transferRateMBps MB/sec"
