{{ config(
     enabled = (var('enable_key_metrics', true) | as_bool) and (var('enable_key_metrics_regression_test', false) | as_bool),
     schema = key_metrics_schema_name(),
     alias = 'analytical_key_metrics_regression',
     tags = ['key_metrics', 'key_metrics_regression'],
     materialized = 'table'
   )
}}

with baseline as (
    select
          cast(id as {{ dbt.type_string() }}) as id
        , cast(category as {{ dbt.type_string() }}) as category
        , cast(metric as {{ dbt.type_string() }}) as metric
        , cast(result as {{ dbt.type_string() }}) as result
    from {{ ref('data_quality__analytical_key_metrics_tuva_synthetic_large') }}
),

actual as (
    select
          cast(id as {{ dbt.type_string() }}) as id
        , cast(category as {{ dbt.type_string() }}) as category
        , cast(metric as {{ dbt.type_string() }}) as metric
        , cast(result as {{ dbt.type_string() }}) as result
    from {{ ref('data_quality__analytical_key_metrics') }}
    where data_source = 'medicare cclf'
),

compared as (
    select
          coalesce(actual.id, baseline.id) as id
        , baseline.category as expected_category
        , actual.category as actual_category
        , baseline.metric as expected_metric
        , actual.metric as actual_metric
        , baseline.result as expected_result
        , actual.result as actual_result
    from baseline
    full outer join actual
        on baseline.id = actual.id
)

select
      id
    , cast(
        case
            when expected_metric is null then 'unexpected_actual_metric'
            when actual_metric is null then 'missing_actual_metric'
            when expected_category <> actual_category then 'category_mismatch'
            when expected_metric <> actual_metric then 'metric_mismatch'
            when expected_result <> actual_result then 'result_mismatch'
        end as {{ dbt.type_string() }}
      ) as difference_type
    , expected_category
    , actual_category
    , expected_metric
    , actual_metric
    , expected_result
    , actual_result
from compared
where expected_metric is null
   or actual_metric is null
   or expected_category <> actual_category
   or expected_metric <> actual_metric
   or expected_result <> actual_result
