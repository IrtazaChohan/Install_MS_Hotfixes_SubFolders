function writelog([string]$result, [string]$logfile) {
    try {
        $objlogfile = new-object system.io.streamwriter("c:\$logfile", [System.IO.FileMode]::Append)
        $objlogfile.writeline("$((Get-Date).ToString()) : $result")
        write-host (Get-Date).ToString() " : $result"  -foregroundcolor yellow
        $objlogfile.close()
    } catch [Exception] {
        Write-Host $result -foregroundcolor red
        $error.clear()
   }
} 

function EXIT_SCRIPT([int]$EXIT_CODE) {

    writelog "$SCRIPT_NAME script ended with code $EXIT_CODE" $LOG
    writelog "==============================" $LOG
    exit $EXIT_CODE

}



$LOG = "Hotfix_Update_Manual.log"
$SERVER_ARCH = ([IntPtr]::Size)*8
$OS_VERSION = (Get-WmiObject -class Win32_OperatingSystem).Version
$OS_VERSION = $OS_VERSION.substring(0,3)
$SCRIPT_NAME = $MyInvocation.MyCommand.Name
$SCRIPT_PATH = split-path $SCRIPT:MyInvocation.MyCommand.Path -parent
$PATCH_PATH = "$SCRIPT_PATH\$($hOS_LIST[$OS_VERSION])\$($SERVER_ARCH)bit"
$FILES = @()


writelog "================================" $log
writelog "'$SCRIPT_PATH\$SCRIPT_NAME' Script Started" $log
writelog "Argument entered: '$action'" $log
writelog "Source folder: '$PATCH_PATH'" $log
writelog "--------------------------------" $log


