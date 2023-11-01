function Remove-MerakiNetworkWirelessEthernetPortsProfile {
    <#
    .SYNOPSIS
    Deletes a network wireless Ethernet ports profile.
    
    .DESCRIPTION
    The Remove-MerakiNetworkWirelessEthernetPortsProfile function allows you to delete a network wireless Ethernet ports profile by providing the authentication token, network ID, and the profile ID.
    
    .PARAMETER AuthToken
    The authentication token (API key) required to access the Meraki Dashboard API.
    
    .PARAMETER NetworkId
    The ID of the network.
    
    .PARAMETER ProfileId
    The ID of the profile to be deleted.
    
    .EXAMPLE
    Remove-MerakiNetworkWirelessEthernetPortsProfile -AuthToken "your-api-token" -NetworkId "1234" -ProfileId "1001"
    
    This example deletes a network wireless Ethernet ports profile with the specified profile ID.
    
    .NOTES
    The function requires the "Invoke-RestMethod" cmdlet to be available.
    
    The function returns the response from the API if the deletion is successful, otherwise, it displays an error message.
    #>
    
        [CmdletBinding()]
        param (
            [parameter(Mandatory=$true)]
            [string]$AuthToken,
            [parameter(Mandatory=$true)]
            [string]$NetworkId,
            [parameter(Mandatory=$true)]
            [string]$ProfileId
        )
    
        try {
            $header = @{
                "X-Cisco-Meraki-API-Key" = $AuthToken
                "content-type" = "application/json; charset=utf-8"
            }
    
            $url = "https://api.meraki.com/api/v1/networks/$NetworkId/wireless/ethernet/ports/profiles/$ProfileId"
    
            $response = Invoke-RestMethod -Method Delete -Uri $url -Header $header
            return $response
        }
        catch {
            Write-Host $_
        }
    }