function Get-MerakiOrganization {
    <#
    .SYNOPSIS
        Retrieves information about a specific Meraki organization.
    .DESCRIPTION
        This function retrieves information about a specific Meraki organization. If no organization ID is specified, it will retrieve information about the first organization associated with the provided API key.
    .PARAMETER AuthToken
        The Meraki API authentication token.
    .PARAMETER OrgID
        The organization ID. If not specified, the first organization associated with the provided API key will be used.
    .EXAMPLE
        PS C:\> Get-MerakiOrganization -AuthToken '12345' -OrgID '54321'
    .EXAMPLE
        PS C:\> Get-MerakiOrganization -AuthToken '12345'
    #>
    param (
        [parameter(Mandatory=$true)]
        [string]$AuthToken,
        [parameter(Mandatory=$false)]
        [string]$OrganizationID = (Get-MerakiOrganizations -AuthToken $AuthToken).id
    )

    try {
        $header = @{
            'X-Cisco-Meraki-API-Key' = $AuthToken
        }
        $response = Invoke-RestMethod -Method Get -Uri "https://api.meraki.com/api/v1/organizations/$OrganizationID" -Header $header
        return $response
    } catch {
        Write-Error $_
    }
}
