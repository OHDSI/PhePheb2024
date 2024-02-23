# Phenotype Phebruary study diagnostics explorer

Steps to add a new app:

1. Upload a dataset to the ohdsi shiny results postgresql db in the schema "phenotype_phebruary"
    * Use a new table prefix to match your study eg. "mmd_2024_" * PLEASE TRY AND AVOID OVERWRITING OTHER STUDY DATA!*

```
    CohortDiagnostics::createResultsDataModel(connectionDetails, databaseSchema = "phenotype_phebruary", tablePrefix = "make_me_unique_")

    CohortDiagnostics::uploadResults(connectionDetails,
                                   schema = databaseSchema,
                                   zipFileName = zipFile,
                                   tablePrefix = tablePrefix)
```
2. Create a new branch in this github repostory and copy one of the *.config.yml files to create a new version
3. Set the results database schema in this config 

```
# Alter these configuration settings for usage with remote databases
connectionDetails:
  dbms: "postgresql"
  port: 5432

# Store connection details as a json string in keyring
# Store with keyring::key_set_with_value("KEYNAME", jsonlite::toJSON(myConnectionDetails))
connectionDetailsSecureKey: ~

# store connection details with environment variables
# Note - if dbms and port vars are unset in environment variables they will default to above connectionDetails settings
connectionEnvironmentVariables:
  dbms: ~
  database: "shinydbDatabase"
  server: "shinydbServer"
  user: "shinydbUser"
  password: "shinydbPw"
  port: "shinydbPort"
  extraSettings: ~

tablePrefix: "mdd_" # SET THIS VALUE!
cohortTableName: "cohort"
databaseTableName: "database"
resultsDatabaseSchema: "phenotype_phebruary"
vocabularyDatabaseSchemas: ["phenotype_phebruary"]
```
4. Create a release of this repo to push a new docker image with the added configuration

5. Go to [ShinyProxyDeploy](https://github.com/OHDSI/ShinyProxyDeploy) and create a pull request with a new addition to application.yml

```
  - id: 16_PhenotypePhebAlzh
    display-name: Phenotype Phebruary Alzheimers
    description: Cohort Diagnostics
    container-cmd: ["R", "-e", "shiny::runApp('/srv/shiny-server/', host = '0.0.0.0', port = 3838)"]
    container-image: ohdsi/phepheb2024:1.0.4
    container-volumes:
      - "/home/jenkins/shinyproxy/.Renviron:/root/.Renviron"
      - "/home/jenkins/minio/data/sp-app-data:/data"
    ccontainer-env:
      CONFIG_FILE: mdd.config.yml
````