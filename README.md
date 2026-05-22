# Key Metrics

The Tuva Key Metrics dbt package builds a curated set of healthcare analytics
metrics on top of the Tuva core platform and related mart packages.

The main output relation is `key_metrics.analytical_key_metrics`. It includes
the current run result plus reference values for Medicare FFS and Tuva synthetic
large data.

This package is intended to be installed alongside `the_tuva_project` and the
mart packages used by the metrics, including quality measures and NYU ED
classification.
