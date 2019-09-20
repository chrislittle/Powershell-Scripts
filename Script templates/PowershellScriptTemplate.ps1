<#
.DESCRIPTION
##*===============================================
##* START - DESCRIPTION
##*===============================================    


The script is provided as a template to perform an install or uninstall of an application(s).
The script either performs an "Install" deployment type or an "Uninstall" deployment type.
The install deployment type is broken down into 3 main sections/phases: Pre-Install, Install, and Post-Install.
The script dot-sources the AppDeployToolkitMain.ps1 script which contains the logic and functions required to install or uninstall an application.


Script author: Morten Pedholt
Script created on: November 2019
Script edited date: April 2020
Script last edited by: Morten Pedholt
Script version: 1.0.0
##*===============================================
##* END - DESCRIPTION
##*===============================================

#>


##*===============================================
##* START - VARIABLES
##*===============================================

[CmdletBinding()]
Param (
    [Parameter(Mandatory=$false)]    
    [string]$modulename = 'MSOnline',
    [Parameter(Mandatory=$false)]    
    [string]$logpath = $env:SystemDrive + '\Scriptlogs\Pedholtlab'
	
)
##*===============================================
##* END - VARIABLES
##*===============================================


##*===============================================
##* START - CHECK FOR LOGGIN IN SCRIPT
##*===============================================

#Start transcript if logpath is defined
if ($logpath) {
    If(!(test-path $logpath)) {
            New-Item -ItemType Directory -Force -Path $logpath  -Verbose

    } else{
        Write-Host "$logpath Directory already exist" -ForegroundColor Cyan
        
    }

 Start-Transcript -Path $logpath\Pedholtlab_$(get-date -f yyyy-MM-dd).txt -IncludeInvocationHeader -Append -Force -Verbose
    }else {
    Write-Host "No logpath is specificed in variables" -ForegroundColor Cyan
}
##*===============================================
##*  END - CHECK FOR LOGGIN IN SCRIPT
##*===============================================


##*===============================================
##*  START - CHECK FOR MODULE IN SCRIPT
##*===============================================

#Check if the required module is installed is installed, if not it will install and import the module.
if ($modulename) {
    $checkmodule = Get-Module -ListAvailable | Where-Object { $_.Name -like $modulename } -Verbose
    if($checkmodule) {
    Write-Host "$modulename is already installed" -ForegroundColor Cyan
    Import-Module $checkmodule.Name
    }
    Else{
    Write-Host "$modulename is not installed, installing $modulename module" -ForegroundColor Green
    Install-Module $modulename -AllowClobber -Verbose
    Import-Module $modulename
    }

} else {
    Write-Host "No module requirements is specificed in variables" -ForegroundColor Cyan
}

##*===============================================
##*  END - CHECK FOR MODULE IN SCRIPT
##*===============================================

##*===============================================
##* START - SCRIPT BODY
##*===============================================




##*===============================================
##* END - SCRIPT BODY
##*===============================================


#Stop Transcript if it's startet
try{
    stop-transcript | out-null
  }
  catch [System.InvalidOperationException]{}



##*===============================================
##* END - CHECK FOR LOGGIN IN SCRIPT
##*===============================================

