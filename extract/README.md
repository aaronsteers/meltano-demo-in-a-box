# Project Extracts Readme

## Snowflake Batch Performance Testing

### Snowflake prereqs

Before you start, you'll need to tell snowflake how to connect. The `/.env/template` file has credentials which you can override for your own environment.

The test data used is from the Snowflake Sample DB. If you've not already done so, you may need to map the DB in your Snowflake admin console and grant access to the specific role which you'll be using for testing.

### Testing process

This project is configured with two instances of tap-snowflake: one with and one without batch config enables.

To test _with_ Snowflake batching enabled:

```console
# First refresh the catalog (if needed) and print the select rules:
time meltano select tap-snowflake-w-batch --list

# Next run the extraction:
time meltano invoke tap-snowflake-w-batch > ./output/batch-enabled-output01.singer.jsonl
```

To test _without_ Snowflake batching enabled:

```console
# First refresh the catalog (if needed) and print the select rules:
time meltano select tap-snowflake --list

# Next run the extraction:
time meltano invoke tap-snowflake > ./output/batch-disabled-output01.singer.jsonl
```

### About the data

The sample source data comes in 4 different sizes. You can easily test with a larger or smaller dataset by modifying the `select` entry to point to a different schema:

```txt
tpch_sf1.orders:      1.5M rows (exactly), compressed size approx 40 MB
tpch_sf10.orders:    15.0M rows (exactly), compressed size approx 425 MB
tpch_sf100.orders:  150.0M rows (exactly), compressed size approx 4.3 GB
tpch_sf1000.orders:   1.5B rows (exactly), compressed size approx 49 GB
```

### Coming soon

TODO: Add similar tests for loading data back to `target-snowflake`, with and without batching enabled.
