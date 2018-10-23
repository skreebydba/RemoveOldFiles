<#
    Created By: Frank Gill, Concurrency, Inc.
    Created: 2018-10-23
#>
function Remove-OldFiles {
  <#
  .SYNOPSIS
  Delete files older than a specified date.
  .DESCRIPTION
  Return a list of files from a specified directory older than a specified in a grid view.  Delete the selected files.
  .EXAMPLE
  Give an example of how to use it
  .EXAMPLE
  Give another example of how to use it
  .PARAMETER filepath 
  The file path to search for old files.
  .PARAMETER extension
  The file extension to delete.
  .PARAMETER days
  Number of days to check for files.
  #>
  [CmdletBinding(SupportsShouldProcess=$True,ConfirmImpact='Low')]
  param
  (
    [Parameter(Mandatory=$True,
    ValueFromPipeline=$True,
    ValueFromPipelineByPropertyName=$True,
      HelpMessage='What file path do you want to delete files from?')]
    [Alias('path')]
    [ValidateLength(3,255)]
    [string[]]$filepath,
    [Parameter(Mandatory=$True,
    ValueFromPipeline=$True,
    ValueFromPipelineByPropertyName=$True,
      HelpMessage='Enter the number of days you want to go back to delete files?')]
    [Alias('days')]
    [int]$numberofdays,
    [Parameter(Mandatory=$False,
    ValueFromPipeline=$True,
    ValueFromPipelineByPropertyName=$True,
      HelpMessage='What file extension do you want to search for?')]
    [Alias('ext')]
    [ValidateLength(1,15)]
    [string]$extension
  )


  process {
        
        $extension = "*" + $extension
        $daterange = $numberofdays * -1;
        Get-ChildItem $filepath -Recurse -File -Filter $extension | Where CreationTime -lt  (Get-Date).AddDays($daterange) | Sort-Object length -Descending | Out-GridView -PassThru | Remove-Item -Force;
      }
    }
