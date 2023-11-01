function Get-MerakiNetworkWirelessSsidEapOverride {
    <#
    .SYNOPSIS
    Retrieves the EAP override settings for a specified SSID in a Meraki network.
    .DESCRIPTION
    This function retrieves the EAP override settings for a specified SSID in a Meraki network using the Meraki Dashboard API.
    .PARAMETER AuthToken
    The Meraki API token for the account.
    .PARAMETER networkId
    The ID of the Meraki network for which to retrieve the EAP override settings.
    .PARAMETER number
    The number of the SSID for which to retrieve the EAP override settings.
    .EXAMPLE
    PS> Get-MerakiNetworkWirelessSsidEapOverride -AuthToken "1234" -networkId "abcd" -number 1
    Retrieves the EAP override settings for SSID 1 in network "abcd" using the Meraki API token "1234".
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$true)]
        [string]$AuthToken,
        [parameter(Mandatory=$true)]
        [string]$networkId,
        [parameter(Mandatory=$true)]
        [string]$number
    )

    try {
        $header = @{
            "X-Cisco-Meraki-API-Key" = $AuthToken
        }

        $response = Invoke-RestMethod -Method Get -Uri "https://api.meraki.com/api/v1/networks/$networkId/wireless/ssids/$number/eapOverride" -Header $header
        return $response
    }
    catch {
        Write-Error $_
    }
}
