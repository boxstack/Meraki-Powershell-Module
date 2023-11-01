function Get-MerakiOrganizationSummaryTopClientsManufacturersByUsage {
    <#
    .SYNOPSIS
    Gets a summary of the top client manufacturers by usage for a specified Meraki organization.
    
    .PARAMETER AuthToken
    The authentication token for the Meraki Dashboard API.
    
    .PARAMETER OrgId
    The ID of the organization to retrieve the top client manufacturers by usage for. If not specified, the function will retrieve the ID of the first organization associated with the API key.
    
    .PARAMETER t0
    The beginning of the timespan for which to retrieve top client manufacturers by usage data. If not specified, the function will use the `t1` and `timespan` parameters instead.
    
    .PARAMETER t1
    The end of the timespan for which to retrieve top client manufacturers by usage data. If not specified, the function will use the `t0` and `timespan` parameters instead.
    
    .PARAMETER timespan
    The duration of the timespan for which to retrieve top client manufacturers by usage data, in seconds. If not specified, the function will use the `t0` and `t1` parameters instead.
    
    .EXAMPLE
    PS C:\> Get-MerakiOrganizationSummaryTopClientsManufacturersByUsage -AuthToken "1234567890" -OrgId "5678901234" -t0 "2022-01-01T00:00:00Z" -t1 "2022-01-31T23:59:59Z"
    Retrieves a summary of the top client manufacturers by usage for the organization with ID "5678901234" for the month of January 2022.
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$true)]
        [string]$AuthToken,
        [parameter(Mandatory=$false)]
        [string]$OrganizationID = (Get-MerakiOrganizations -AuthToken $AuthToken).id,
        [parameter(Mandatory=$false)]
        [string]$t0 = $null,
        [parameter(Mandatory=$false)]
        [string]$t1 = $null,
        [parameter(Mandatory=$false)]
        [int]$timespan = $null
    )
    try {
        $header = @{
            "X-Cisco-Meraki-API-Key" = $AuthToken
            "Content-Type" = "application/json"
        }
        $queryParams = @{}
        if ($timespan) {
            $queryParams['timespan'] = $timespan
        } else {
            if ($t0) {
                $queryParams['t0'] = $t0
            }
            if ($t1) {
                $queryParams['t1'] = $t1
            }
        }
        $queryString = New-MerakiQueryString -queryParams $queryParams
    
        $URL = "https://api.meraki.com/api/v1/organizations/$OrganizationID/summary/top/clients/manufacturers/byUsage?$queryString"
    
        $URI = [uri]::EscapeUriString($URL)
    
        $response = Invoke-RestMethod -Method Get -Uri $URI -Header $header
        return $response
    } catch {
        Write-Error $_
    }
}