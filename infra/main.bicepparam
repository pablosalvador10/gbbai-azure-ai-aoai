using './main.bicep'

// parameters westus 

/*
param location = 'eastus'
param aoaiServiceName = 'aoai-dev-eastus-psl-001'
param aoai_deployments_name = ['gpt35-turbo', 'gpt4-32k']
param aoai_model_type  = ['gpt-35-turbo', 'gpt-35-turbo-16k']
param aoai_model_version = ['0613','0613']
param capacity = [30,35]
*/

// parameters eastus 

param location = 'canadaeast'
param prefix = 'dev-aoai'
param aoai_deployments_name = ['gpt35-turbo', 'gpt4-32k']
param aoai_model_type  = ['gpt-35-turbo', 'gpt-4-32k']
param aoai_model_version = ['0613','0613']
param capacity = [30,35]

