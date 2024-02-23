#!/bin/sh

# Check if CONFIG_FILE is set and is not 'config.yml'
if [ ! -z "$CONFIG_FILE" ] && [ "$CONFIG_FILE" != "config.yml" ]; then
    # Copy CONFIG_FILE to 'config.yml'
    cp $CONFIG_FILE config.yml
fi

# Run the Shiny app
R -e "shiny::runApp('/srv/shiny-server/', host = '0.0.0.0', port = 3838)"