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

RUN mkdir outcomes
RUN mkdir outcomes/data
RUN mkdir indications
RUN mkdir indications/data

RUN cp server.R outcomes/
RUN cp ui.R outcomes/
RUN cp global.R outcomes/
RUN cp config.yml outcomes/

RUN cp server.R indications/
RUN cp ui.R indications/
RUN cp global.R indications/
RUN cp config.yml indications/

COPY indications.sqlite indications/data/MergedCohortDiagnosticsData.sqlite
COPY outcomes.sqlite outcomes/data/MergedCohortDiagnosticsData.sqlite
# Expose default Shiny app port
EXPOSE 3838
# Run the Shiny app
CMD R -e "shiny::runApp('$APP_DIR', host = '0.0.0.0', port = 3838)"
