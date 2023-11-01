function New-MerakiOrganizationCameraRole {
    <#
    .SYNOPSIS
    Creates a new camera role for a Meraki organization using the Meraki Dashboard API.
    
    .DESCRIPTION
    The New-MerakiOrganizationCameraRole function allows you to create a new camera role for a specified Meraki organization by providing the authentication token, organization ID, and a camera role configuration string.
    
    .PARAMETER AuthToken
    The authentication token (API key) required to access the Meraki Dashboard API.
    
    .PARAMETER OrganizationId
    The ID of the Meraki organization for which you want to create the new camera role.
    
    .PARAMETER CameraRoleConfig
    A string containing the camera role configuration. The string should be in JSON format and should include the properties as defined in the schema.
    
    .EXAMPLE
    $CameraRoleConfig = '{
        "name": "Security_Guard",
        "appliedOnDevices": [
            {
                "tag": "reception-desk",
                "id": "",
                "permissionScopeId": "1"
            }
        ],
        "appliedOnNetworks": [
            {
                "tag": "building-a",
                "id": "",
                "permissionScopeId": "2"
            }
        ],
        "appliedOrgWide": [
            {
                "tag": "building-a",
                "id": "",
                "permissionScopeId": "2"
            }
        ]
    }'
    $CameraRoleConfig = $CameraRoleConfig | ConvertTo-Json -Compress
    
    New-MerakiOrganizationCameraRole -AuthToken "your-api-token" -OrganizationId "1234567890" -CameraRoleConfig $CameraRoleConfig
    
    This example creates a new camera role for the Meraki organization with ID "1234567890".
    
    .NOTES
    The function requires the "Invoke-RestMethod" cmdlet to be available.
    
    The function returns the response from the API if the creation is successful, otherwise, it displays an error message.
    #>
    
        [CmdletBinding()]
        param (
            [parameter(Mandatory=$true)]
            [string]$AuthToken,
            [parameter(Mandatory=$false)]
        [string]$OrganizationId = (Get-MerakiOrganizations -AuthToken $AuthToken).id,
            [parameter(Mandatory=$true)]
            [string]$CameraRoleConfig
        )
    
        try {
            $header = @{
                "X-Cisco-Meraki-API-Key" = $AuthToken
                "content-type" = "application/json; charset=utf-8"
            }
    
            $url = "https://api.meraki.com/api/v1/organizations/$OrganizationId/camera/roles"
    
            $response = Invoke-RestMethod -Method Post -Uri $url -Header $header -Body $CameraRoleConfig
            return $response
        }
        catch {
            Write-Host $_
        }
    }