$path = "C:\Backup\skreeby";
$exists = Test-Path $path;

if($exists -eq $true)
{
    Write-Output "$path exists";
}
else
{
    "WAH waaaaaahhh!!!";
}