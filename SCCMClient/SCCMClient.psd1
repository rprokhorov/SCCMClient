#
# Module manifest for module 'Create-SCCMCollections'
#
# Generated by: Roman Prokhorov
#
# Generated on: 2019.07.13
#
@{
    # Version number of this module.
    ModuleVersion     = '1.0.4'

    # ID used to uniquely identify this module
    GUID              = '694b8b15-5e35-4801-87dd-28e272076c73'

    # Author of this module
    Author            = 'Prokhorov Roman'

    # Company or vendor of this module
    CompanyName       = 'Prokhorov Roman'

    # Copyright statement for this module
    Copyright         = '2019 Prokhorov Roman'

    # Description of the functionality provided by this module
    Description       = 'SCCM Client Management Module.'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '3.0'

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules   = @()

    # Script module or binary module file associated with this manifest.
    RootModule        = 'SCCMClient.psm1'

    FunctionsToExport = @(
        'Invoke-SCCMClientCycle', 'Repair-SCCMWindowsUpdate', 'Clear-SCCMCache', 'Start-TaskSequence'
    )

    PrivateData       = @{
        # PSData is module packaging and gallery metadata embedded in PrivateData
        # It's for rebuilding PowerShellGet (and PoshCode) NuGet-style packages
        # We had to do this because it's the only place we're allowed to extend the manifest
        # https://connect.microsoft.com/PowerShell/feedback/details/421837
        PSData = @{
            # The primary categorization of this module (from the TechNet Gallery tech tree).
            Category     = 'SCCM'

            # Keyword tags to help users find this module via navigations and search.
            Tags         = @('SCCM', 'ConfigMgr', 'Client')

            # The web address of an icon which can be used in galleries to represent this module
            IconUri      = ''

            # Indicates this is a pre-release/testing version of the module.
            IsPrerelease = 'False'
        }
    }
}