A docker compose file for running the Wallaroo example application.

TODO:
 - Map the local directory to the machida service so that edits can be made to the wallaroo applications
 - Replace the hard coded commands with bash scripts that populate environment variables
 - Set up an .dev_env that populates applications as well and sender and receiver behavior
 - Add a simple wrapper script to the machida service to intercept SIGTERM and run cluster_shutdown
 - Set up dynamic python path to enable local development via the mapped volume
   - remember to prevent bytecode generation
 - Investiage what stateful information wallaroo writes to the filesystem and volume map those locations
 - Experiment with clustering

