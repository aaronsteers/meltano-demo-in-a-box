build:
	meltano install

run:
	meltano run tap-spreadsheets-anywhere add-timestamps target-duckdb --full-refresh dbt-duckdb:build

parquet:
	meltano run tap-spreadsheets-anywhere add-timestamps target-parquet --full-refresh;\
	meltano invoke dbt-duckdb build --target parquet

pipeline:
	meltano run tap-spreadsheets-anywhere add-timestamps target-duckdb --full-refresh;\
	meltano invoke dbt-duckdb run-operation elo_rollforward;\
	meltano run dbt-duckdb:build