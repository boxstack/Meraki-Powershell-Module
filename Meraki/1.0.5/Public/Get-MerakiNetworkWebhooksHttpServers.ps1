function Get-MerakiNetworkWebhooksHttpServers {
    <#
    .SYNOPSIS
    Retrieves the HTTP servers for a given Meraki network.

    .DESCRIPTION
    This function retrieves the HTTP servers for a given Meraki network using the Meraki Dashboard API.

    .PARAMETER AuthToken
    The API token generated in the Meraki Dashboard.

    .PARAMETER NetworkId
    The ID of the Meraki network.

    .EXAMPLE
    PS C:> Get-MerakiNetworkWebhooksHttpServers -AuthToken '12345' -NetworkId 'N_1234567890'

    This command retrieves the HTTP servers for the Meraki network with the ID 'N_1234567890' using the API token '12345'.

    .INPUTS
    None.

    .OUTPUTS
    The function returns a collection of HTTP server objects.

    .NOTES
    For more information on the Meraki Dashboard API, please visit https://developer.cisco.com/meraki/api/.

    #>
    [CmdletBinding()]
    param (
    [parameter(Mandatory=$true)]
    [string]$AuthToken,
    [parameter(Mandatory=$true)]
    [string]$NetworkId
    )
    try {
        $header = @{
            'X-Cisco-Meraki-API-Key' = $AuthToken
        }
        $response = Invoke-RestMethod -Method Get -Uri "https://api.meraki.com/api/v1/networks/$NetworkId/webhooks/httpServers" -Header $header -UserAgent "MerakiPowerShellModule/1.0.2 DocNougat"
        return $response
    }
    catch {
        Write-Host $_
        Throw $_
    }
}    