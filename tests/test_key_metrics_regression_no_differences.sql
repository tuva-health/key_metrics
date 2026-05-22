{{ config(
     enabled = (var('enable_key_metrics', true) | as_bool) and (var('enable_key_metrics_regression_test', false) | as_bool),
     tags = ['key_metrics', 'key_metrics_regression']
   )
}}

select *
from {{ ref('data_quality__analytical_key_metrics_regression') }}
