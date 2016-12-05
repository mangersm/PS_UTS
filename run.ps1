Function Get-ChildItemToDepth { 
  Param( 
    [String]$Path = "C:\utils\test", 
    [Byte]$ToDepth = 0, 
    [Byte]$CurrentDepth = 0, 
    [string]$CSVOutput = "C:\utils\output\out.dat" 
  ) 
  
   $CurrentDepth++ 
  
   Get-ChildItem $Path | where {$_.PSIsContainer} | Where-Object {$_.LastWriteTime -le "03/29/2016" } | %{ #Change this line for NBC. PS version issue 
   $workingdir = $_.FullName
   $olddate = $_.LastWriteTime
   $firstfile = Get-ChildItem $_.FullName | Select-Object -last 1
   $newdate = $firstfile.LastWriteTime
   
   ###############--for logging purposes--############
   $_.Name,$firstfile.Name,$olddate,$newdate -join ',' | Out-File -Append $CSVOutput
   
   if ($newdate) {$_.LastWriteTime = $newdate}
   
   
   }
   } 
Get-ChildItemToDepth
