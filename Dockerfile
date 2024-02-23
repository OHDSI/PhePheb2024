# Set base image
FROM ohdsi/diagnosticsexplorer:3.2.5

# Set an argument for the app name
ARG APP_NAME
# Set arguments for the GitHub branch and commit id abbreviation
ARG GIT_BRANCH=unknown
ARG GIT_COMMIT_ID_ABBREV=unknown

# Set workdir and copy app files
WORKDIR /srv/shiny-server/

COPY global.R ./
COPY alzh.config.yml ./config.yml
COPY mdd.config.yml  ./

# Expose default Shiny app port
EXPOSE 3838
# Run the Shiny app
CMD R -e "shiny::runApp('/srv/shiny-server/', host = '0.0.0.0', port = 3838)"
