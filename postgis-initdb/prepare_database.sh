#!/bin/bash

DUMP_FILENAME='postgis_ltj_tietokanta_dumppi_obfuskoitu.backup'
DUMP_FILE_PATH="/docker-entrypoint-initdb.d/$DUMP_FILENAME"

psql --username "ltj" --dbname "$POSTGRES_DB" --host "postgis" --port 5432 <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS postgis;

    CREATE ROLE katselu;
    CREATE ROLE ltj_yllapito;
    CREATE ROLE ltj_katselu;
    CREATE ROLE ltj_testi;

    CREATE SCHEMA ltj;
    CREATE SCHEMA ltj_wfs_virka;
    CREATE SCHEMA ltj_wfs_avoin;

    REVOKE CREATE ON SCHEMA public FROM PUBLIC;
    GRANT CREATE ON SCHEMA public TO ltj;

    ALTER DATABASE ltj SET default_transaction_read_only TO 'off';
EOSQL

if [ -f "$DUMP_FILE_PATH" ]; then
  echo 'Restoring database from dump'
  echo "  postgis://$POSTGRES_USER@localhost/$POSTGRES_DB"

  pg_restore --username="ltj" --dbname="$POSTGRES_DB" --clean --if-exists --verbose "$DUMP_FILE_PATH" --host "postgis" --port 5432
else
  echo "No dump file found."
fi
