function Get-MerakiDeviceSwitchRoutingStaticRoute {
    <#
    .SYNOPSIS
    Retrieves information about a specific static route on a Meraki switch device.
    
    .DESCRIPTION
    This function retrieves information about a specific static route on a Meraki switch device, specified by its staticRouteId parameter.
    
    .PARAMETER AuthToken
    The API token generated by Meraki to authenticate API requests.
    
    .PARAMETER deviceSerial
    The serial number of the Meraki switch device.
    
    .PARAMETER staticRouteId
    The ID of the static route to retrieve information about.
    
    .EXAMPLE
    PS C:\> Get-MerakiDeviceSwitchRoutingStaticRoute -AuthToken "1234" -deviceSerial "Q2HP-XXXX-XXXX" -staticRouteId "1234"
    
    Retrieves information about the static route with ID "1234" on the Meraki switch device with serial number "Q2HP-XXXX-XXXX".
    
    .NOTES
    For more information about the Meraki Dashboard API, see https://developer.cisco.com/meraki/api-v1/.
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$true)]
        [string]$AuthToken,
        [parameter(Mandatory=$true)]
        [string]$DeviceSerial,
        [parameter(Mandatory=$true)]
        [string]$staticRouteId
    )
    try {
        $header = @{
            "X-Cisco-Meraki-API-Key" = $AuthToken
        }
        $response = Invoke-RestMethod -Method Get -Uri "https://api.meraki.com/api/v1/devices/$DeviceSerial/switch/routing/staticRoutes/$staticRouteId" -Header $header -UserAgent "MerakiPowerShellModule/1.0.2 DocNougat"
        return $response
    }
    catch {
        Write-Host $_
        Throw $_
    }
}
