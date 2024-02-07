# Set base image
FROM ohdsi/diagnosticsexplorer:3.2.5

# Set an argument for the app name
ARG APP_NAME
# Set arguments for the GitHub branch and commit id abbreviation
ARG GIT_BRANCH=unknown
ARG GIT_COMMIT_ID_ABBREV=unknown

ENV APP_DIR=/srv/shiny-server/outcomes

# Set workdir and copy app files
WORKDIR /srv/shiny-server/

RUN mkdir data/

RUN cp server.R ./
RUN cp ui.R ./
RUN cp global.R ./
RUN cp config.yml ./

COPY *.sqlite ./data/
# Expose default Shiny app port
EXPOSE 3838
# Run the Shiny app
CMD R -e "shiny::runApp('/srv/shiny-server/', host = '0.0.0.0', port = 3838)"
