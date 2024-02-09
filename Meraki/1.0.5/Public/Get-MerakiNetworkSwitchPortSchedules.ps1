function Get-MerakiNetworkSwitchPortSchedules {
    <#
    .SYNOPSIS
        Gets the port schedules for a Meraki network switch.
    .DESCRIPTION
        This function retrieves the port schedules for a Meraki network switch using the Meraki Dashboard API.
    .PARAMETER AuthToken
        The API authentication token for the Meraki Dashboard.
    .PARAMETER networkId
        The ID of the Meraki network to retrieve the port schedules for.
    .EXAMPLE
        PS C:\> Get-MerakiNetworkSwitchPortSchedules -AuthToken "api_token" -networkId "L_123456789"
        Returns the port schedules for the specified Meraki network switch.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$AuthToken,
        [Parameter(Mandatory=$true)]
        [string]$networkId
    )

    try {
        $header = @{
            "X-Cisco-Meraki-API-Key" = $AuthToken
        }
        $response = Invoke-RestMethod -Method Get -Uri "https://api.meraki.com/api/v1/networks/$networkId/switch/portSchedules" -Header $header -UserAgent "MerakiPowerShellModule/1.0.2 DocNougat"
        return $response
    }
    catch {
        Write-Host $_
        Throw $_
    }
}
