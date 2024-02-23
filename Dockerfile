# Set base image
FROM ohdsi/diagnosticsexplorer:3.2.5

# Set an argument for the app name
ARG APP_NAME
# Set arguments for the GitHub branch and commit id abbreviation
ARG GIT_BRANCH=unknown
ARG GIT_COMMIT_ID_ABBREV=unknown
ENV CONFIG_FILE=config.yml

# Set workdir and copy app files
WORKDIR /srv/shiny-server/

COPY global.R ./
COPY *.config.yml ./
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose default Shiny app port
EXPOSE 3838
# Run the Shiny app
CMD ["/start.sh"]
