function Get-MerakiOrganizationLoginSecurity {
    <#
    .SYNOPSIS
        Retrieves login security settings for a Meraki organization.
    .DESCRIPTION
        This function retrieves login security settings for a Meraki organization
        specified by the provided organization ID or the ID of the first organization
        associated with the provided API authentication token.
    .PARAMETER AuthToken
        The Meraki API authentication token to use for the request.
    .PARAMETER OrgId
        The ID of the Meraki organization to retrieve login security settings for.
        If not specified, the ID of the first organization associated with the provided
        authentication token will be used.
    .EXAMPLE
        PS C:\> Get-MerakiOrganizationLoginSecurity -AuthToken "myAuthToken" -OrgId "123456"
        Returns login security settings for the Meraki organization with ID "123456".
    #>
    [CmdletBinding()]
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

        $response = Invoke-RestMethod -Method Get -Uri "https://api.meraki.com/api/v1/organizations/$OrganizationID/loginSecurity" -Header $header
        return $response
    }
    catch {
        Write-Error $_
    }
}
