function Get-MerakiOrganizationActionBatch {
    <#
    .SYNOPSIS
    Retrieves an action batch for an organization in the Meraki dashboard.

    .DESCRIPTION
    The Get-MerakiOrganizationActionBatch function retrieves an action batch for an organization in the Meraki dashboard using the Meraki Dashboard API. You must provide an API key and the ID of the action batch. You can optionally provide the ID of the organization that the action batch belongs to.

    .PARAMETER AuthToken
    The Meraki Dashboard API key.

    .PARAMETER ActionBatchID
    The ID of the action batch to retrieve.

    .PARAMETER OrgID
    The ID of the organization that the action batch belongs to. If not provided, the ID of the first organization returned by Get-MerakiOrganizations will be used.

    .EXAMPLE
    PS C:\> Get-MerakiOrganizationActionBatch -AuthToken "your_api_key" -ActionBatchID "your_action_batch_id"

    Retrieves the specified action batch in the first organization returned by Get-MerakiOrganizations.

    .NOTES
    For more information on the Meraki Dashboard API, see https://developer.cisco.com/meraki/api/.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$AuthToken,
        [Parameter(Mandatory=$true)]
        [string]$ActionBatchID,
        [Parameter(Mandatory=$false)]
        [string]$OrganizationID = (Get-MerakiOrganizations -AuthToken $AuthToken)[0].id
    )

    try {
        $header = @{
            "X-Cisco-Meraki-API-Key" = $AuthToken
        }
        $response = Invoke-RestMethod -Method Get -Uri "https://api.meraki.com/api/v1/organizations/$OrganizationID/actionBatches/$ActionBatchID" -Header $header
        return $response
    } catch {
        Write-Error $_
    }
}
