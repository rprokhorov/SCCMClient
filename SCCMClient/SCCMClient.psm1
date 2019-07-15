# Parameter help description

Function Start-TaskSequence{
    Param ( [parameter(Mandatory = $true)] [string]$Name )
    Try {
        Write-Log -Message "Connecting to the SCCM client Software Center..."
        $softwareCenter = New-Object -ComObject "UIResource.UIResourceMgr"
    }
    Catch
    {
        Throw "Could not connect to the client Software Center."
    }
    If ($softwareCenter) {
        Write-Log -Message "Searching for deployments for task sequence [$name]..."
        $taskSequence = $softwareCenter.GetAvailableApplications() | Where-Object { $_.PackageName -eq "$Name" }
        If ($taskSequence)
        {
            $taskSequenceProgramID = $taskSequence.ID
            $taskSequencePackageID = $taskSequence.PackageID
            Write-Log -Message "Found task sequence [$name] with package ID [$taskSequencePackageID]." # Start the task sequence
            Try
            {
                Write-Log -Message "Executing task sequence [$name]..."
                $softwareCenter.ExecuteProgram($taskSequenceProgramID, $taskSequencePackageID, $true)
                Write-Log -Message "Task Sequence started."
            }
            Catch
            {
                Throw "Failed to start the task sequence [$name]"
            }
        }
    }
}

function Invoke-SCCMClientCycle{
Param(
    # Parameter help description
    [Parameter(Mandatory=$True,ValueFromPipeline=$true)]
    [ValidateSet('AMT Status Check Policy', 'Application manager global evaluation action', 'Application manager policy action', 'Application manager user policy action', 'Branch Distribution  oint Maintenance Task', 'Clearing proxy settings cache', 'Client Machine Authentication', 'DCM policy', 'Discovery Data Collection Cycle', 'Discovery Inventory', 'Endpoint AM policy reevaluate', 'Endpoint deployment reevaluate', 'Evaluate Machine Policies', 'External event detection', 'File Collection', 'File Collection Cycle', 'Hardware Inventory', 'Hardware Inventory (Full)', 'Hardware Inventory Collection Cycle', 'IDMIF Collection', 'IDMIF Collection Cycle', 'LS (Location Service) Refresh Locations Task', 'LS (Location Service) Timeout Refresh Task', 'Machine Policy Agent Cleanup', 'NAP action', 'Peer DP Pending package check schedule', 'Peer DP Status reporting', 'Policy Agent Evaluate Assignment (User)', 'Policy Agent Request Assignment (User)', 'Policy Agent Validate Machine Policy / Assignment',  'Policy Agent Validate User Policy / Assignment', 'Power management start summarizer', 'Refresh Default MP Task', 'Request Machine Assignments', 'Retrying/Refreshing certificates in AD on MP', 'Scan by Update Source', 'Send Unsent State Message', 'Software Inventory', 'Software Inventory Collection Cycle', 'Software Metering Generating Usage Report', 'Software Metering Usage Report Cycle', 'Software Updates Assignments Evaluation Cycle', 'Source Update Message', 'State system policy bulk send high', 'State system policy bulk send low', 'State System policy cache cleanout', 'SUM Updates install schedule', 'Update Store Policy', 'User Policy Agent Cleanup', 'Windows Installer Source List Update Cycle')]
    [string]$CycleName
)

    $hash =@{
        'Hardware Inventory' = '{00000000-0000-0000-0000-000000000001}'
        'Hardware Inventory (Full)' = '{00000000-0000-0000-0000-000000000001}'
        'Software Inventory' = '{00000000-0000-0000-0000-000000000002}'
        'Discovery Inventory' = '{00000000-0000-0000-0000-000000000003}'
        'File Collection' = '{00000000-0000-0000-0000-000000000010}'
        'IDMIF Collection' = '{00000000-0000-0000-0000-000000000011}'
        'Client Machine Authentication' = '{00000000-0000-0000-0000-000000000012}'
        'Request Machine Assignments' = '{00000000-0000-0000-0000-000000000021}'
        'Evaluate Machine Policies' = '{00000000-0000-0000-0000-000000000022}'
        'Refresh Default MP Task' = '{00000000-0000-0000-0000-000000000023}'
        'LS (Location Service) Refresh Locations Task' = '{00000000-0000-0000-0000-000000000024}'
        'LS (Location Service) Timeout Refresh Task' = '{00000000-0000-0000-0000-000000000025}'
        'Policy Agent Request Assignment (User)' = '{00000000-0000-0000-0000-000000000026}'
        'Policy Agent Evaluate Assignment (User)' = '{00000000-0000-0000-0000-000000000027}'
        'Software Metering Generating Usage Report' = '{00000000-0000-0000-0000-000000000031}'
        'Source Update Message' = '{00000000-0000-0000-0000-000000000032}'
        'Clearing proxy settings cache' = '{00000000-0000-0000-0000-000000000037}'
        'Machine Policy Agent Cleanup' = '{00000000-0000-0000-0000-000000000040}'
        'User Policy Agent Cleanup' = '{00000000-0000-0000-0000-000000000041}'
        'Policy Agent Validate Machine Policy / Assignment' = '{00000000-0000-0000-0000-000000000042}'
        'Policy Agent Validate User Policy / Assignment' = '{00000000-0000-0000-0000-000000000043}'
        'Retrying/Refreshing certificates in AD on MP' = '{00000000-0000-0000-0000-000000000051}'
        'Peer DP Status reporting' = '{00000000-0000-0000-0000-000000000061}'
        'Peer DP Pending package check schedule' = '{00000000-0000-0000-0000-000000000062}'
        'SUM Updates install schedule' = '{00000000-0000-0000-0000-000000000063}'
        'NAP action' = '{00000000-0000-0000-0000-000000000071}'
        'Hardware Inventory Collection Cycle' = '{00000000-0000-0000-0000-000000000101}'
        'Software Inventory Collection Cycle' = '{00000000-0000-0000-0000-000000000102}'
        'Discovery Data Collection Cycle' = '{00000000-0000-0000-0000-000000000103}'
        'File Collection Cycle' = '{00000000-0000-0000-0000-000000000104}'
        'IDMIF Collection Cycle' = '{00000000-0000-0000-0000-000000000105}'
        'Software Metering Usage Report Cycle' = '{00000000-0000-0000-0000-000000000106}'
        'Windows Installer Source List Update Cycle' = '{00000000-0000-0000-0000-000000000107}'
        'Software Updates Assignments Evaluation Cycle' = '{00000000-0000-0000-0000-000000000108}'
        'Branch Distribution Point Maintenance Task' = '{00000000-0000-0000-0000-000000000109}'
        'DCM policy' = '{00000000-0000-0000-0000-000000000110}'
        'Send Unsent State Message' = '{00000000-0000-0000-0000-000000000111}'
        'State System policy cache cleanout' = '{00000000-0000-0000-0000-000000000112}'
        'Scan by Update Source' = '{00000000-0000-0000-0000-000000000113}'
        'Update Store Policy' = '{00000000-0000-0000-0000-000000000114}'
        'State system policy bulk send high' = '{00000000-0000-0000-0000-000000000115}'
        'State system policy bulk send low' = '{00000000-0000-0000-0000-000000000116}'
        'AMT Status Check Policy' = '{00000000-0000-0000-0000-000000000120}'
        'Application manager policy action' = '{00000000-0000-0000-0000-000000000121}'
        'Application manager user policy action' = '{00000000-0000-0000-0000-000000000122}'
        'Application manager global evaluation action' = '{00000000-0000-0000-0000-000000000123}'
        'Power management start summarizer' = '{00000000-0000-0000-0000-000000000131}'
        'Endpoint deployment reevaluate' = '{00000000-0000-0000-0000-000000000221}'
        'Endpoint AM policy reevaluate' = '{00000000-0000-0000-0000-000000000222}'
        'External event detection' = '{00000000-0000-0000-0000-000000000223}'
    }
    if ($CycleName -eq 'Hardware Inventory (Full)')
    {
        Get-WmiObject -Namespace "root\ccm\invagt" -Class InventoryActionStatus | Where-Object {$_.InventoryActionID -eq $hash[$CycleName]} | Remove-WmiObject
        try {
        Invoke-WmiMethod -Namespace root\ccm -Class SMS_Client -Name TriggerSchedule -ArgumentList $hash[$CycleName]
        }
        catch {
        }
    }
    else{
        Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule $hash[$CycleName]
    }
    
}

function Repair-SCCMWindowsUpdate
{
    Stop-Service wuauserv, CcmExec 
    Remove-Item "$env:SystemRoot\SoftwareDistribution" -Recurse
    Start-Service wuauserv, CcmExec
}

function Clear-SCCMCache
{
    $resman= New-Object -ComObject "UIResource.UIResourceMgr"
    $cacheInfo=$resman.GetCacheInfo()
    $cacheinfo.GetCacheElements() | ForEach-Object {$cacheInfo.DeleteCacheElement($_.CacheElementID)}
}