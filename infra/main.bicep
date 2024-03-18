@description('Location for all resources.')
@allowed([
  'australiaeast'
  'canadaeast'
  'eastus'
  'westus'
  'eastus2'
  'francecentral'
  'japaneast'
  'northcentralus'
  'southcentralus'
  'swedencentral'
  'switzerlandnorth'
  'uksouth'
  'westeurope'
])
param location string

@allowed([
  'gpt-4'
  'gpt-4-32k'
  'gpt-35-turbo'
  'gpt-35-turbo-16k'
])
param aoai_model_type string[]

param aoai_model_version string[]

@description('''The capacity of the deployment in 1000 units. 
The number of items in the array should match the number of deployments.
For e.g to provision 30K TPM, set capacity to 30. Max value of capacity is 300.
''')
param capacity int[]

@description('Azure OpenAI deployment name.')
param aoai_deployments_name string[]

param prefix string

@description('Specifies all secrets wrapped in a secure object.')
@secure()
param secretsObject object

//****************************************************************************************
// Variables
//****************************************************************************************

var resourceGroupName = '${prefix}-rg'
var apiManagementName = '${prefix}-apim'
var keyVaultName = '${prefix}-kv'
var eventHubNamespaceName = '${prefix}-evhns'
var eventHubName = '${prefix}-evh'
var logAnalyticsWorkspaceName = '${prefix}-log'
var applicationInsightsName = '${prefix}-appi'
var storageAccountName = '${prefix}st'
var streamAnalyticsName = '${prefix}-asa'
var aoaiServiceName = '${prefix}-aoai-${location}'

// For all subsequent resources we will set the scope to be the Resource Group we're creating here.
targetScope = 'subscription'
resource deployResourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: resourceGroupName
  location: location
  properties: {}
}

module aoai './modules/aoai.bicep' = {
  name: 'aoai-deployment'
  scope: deployResourceGroup
  params: {
    location: location
    aoaiServiceName: aoaiServiceName
    deployments: [
      {
        name: aoai_deployments_name[0]
        model: {
          format: 'OpenAI'
          name: aoai_model_type[0]
          version: aoai_model_version[0]
        }
        raiPolicyName: 'CustomRaiPolicy_1'
        sku: {
          name: 'Standard'
          capacity: capacity[0]
        }
      }
      {
        name: aoai_deployments_name[1]
        model: {
          format: 'OpenAI'
          name: aoai_model_type[1]
          version: aoai_model_version[1]
        }
        raiPolicyName: 'CustomRaiPolicy_1'
        sku: {
          name: 'Standard'
          capacity: capacity[1]
        }
      }
    ]
  }
}

module aoairole './modules/aoairoles.bicep' = {
  name: 'aoai-role-deployment'
  scope: deployResourceGroup
  params: {
    aoaiServiceName: aoaiServiceName
  }
  dependsOn: [
    aoai
  ]
}

module deployAPIM './modules/apimService.bicep' = {
  name: 'APIM'
  scope: deployResourceGroup
  params: {
    apiManagementName: apiManagementName
    location: location
  }
  dependsOn: [
    deployApplicationInsights
    deployEventHub
    deployKeyVault
  ]
}

module deployAPIMConfiguration './modules/apimServiceConfiguration.bicep' = {
  name: 'APIMConfiguration'
  scope: deployResourceGroup
  params: {
    apiManagementName: apiManagementName
    applicationInsightsName: applicationInsightsName
    eventHubNamespaceName: eventHubNamespaceName
    eventHubName: eventHubName
    keyVaultName: keyVaultName
    secretsObject: secretsObject
  }
  dependsOn: [
    deployAPIM
    deployKeyVault
    deployRoleAssignments
  ]
}

module deployKeyVault './modules/keyvault.bicep' = {
  name: 'KeyVault'
  scope: deployResourceGroup
  params: {
    keyVaultName: keyVaultName
    location: location
    secretsObject: secretsObject
  }
}

module deployEventHub './modules/eventhub.bicep' = {
  name: 'EventHub'
  scope: deployResourceGroup
  params: {
    eventHubNamespaceName: eventHubNamespaceName
    eventHubName: eventHubName
    location: location
  }
  dependsOn: [
    deployKeyVault
  ]
}

module deployLogAnalyticsWorkspace './modules/loganalytics.bicep' = {
  name: 'LogAnalyticsWorkspace'
  scope: deployResourceGroup
  params: {
    logAnalyticsWorkspaceName: logAnalyticsWorkspaceName
    location: location
  }
  dependsOn: [
    deployKeyVault
  ]
}

module deployApplicationInsights './modules/appinsights.bicep' = {
  name: 'ApplicationInsights'
  scope: deployResourceGroup
  params: {
    applicationInsightsName: applicationInsightsName
    location: location
    workspaceResourceId: deployLogAnalyticsWorkspace.outputs.logAnalyticsWorkspaceId
  }
  dependsOn: [
    deployLogAnalyticsWorkspace
    deployKeyVault
  ]
}

module deployStorageAccount './modules/storageaccount.bicep' = {
  name: 'StorageAccount'
  scope: deployResourceGroup
  params: {
    storageAccountName: storageAccountName
    location: location
  }
  dependsOn: [
    deployKeyVault
  ]
}

module deployStreamAnalytics './modules/streamanalytics.bicep' = {
  name: 'StreamAnalytics'
  scope: deployResourceGroup
  params: {
    streamAnalyticsName: streamAnalyticsName
    location: location
  }
  dependsOn: [
    deployEventHub
    deployStorageAccount
    deployKeyVault
  ]
}

module deployRoleAssignments './modules/roleAssignment.bicep' = {
  name: 'roleAssignments'
  scope: deployResourceGroup
  params: {
    APIMPrincipalId: deployAPIM.outputs.managedIdentityPrincipalID
    keyVaultName: keyVaultName
  }
  dependsOn: [
    deployAPIM
    deployKeyVault
  ]
}
