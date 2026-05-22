{{ config(
     enabled = var('enable_key_metrics', true) | as_bool,
     schema = key_metrics_schema_name(),
     alias = 'analytical_key_metrics',
     tags = ['key_metrics'],
     materialized = 'table'
   )
}}

{% set metric_manifest = dq_analytical_metric_manifest() %}

{% if metric_manifest | length > 0 %}
    with metric_manifest as (
        {% for spec in metric_manifest %}
            select
                  cast('{{ spec['model_name'] }}' as {{ dbt.type_string() }}) as model_name
                , cast({{ spec['sort_order'] }} as {{ dbt.type_int() }}) as sort_order
                , cast('{{ spec['result_type'] }}' as {{ dbt.type_string() }}) as result_type
            {% if not loop.last %}union all{% endif %}
        {% endfor %}
    ),
    unioned_metrics as (
        {% for spec in metric_manifest %}
            select
                  cast('{{ spec['model_name'] }}' as {{ dbt.type_string() }}) as model_name
                , cast(data_source as {{ dbt.type_string() }}) as data_source
                , cast(category as {{ dbt.type_string() }}) as category
                , cast(metric as {{ dbt.type_string() }}) as metric
                , cast(result as {{ dbt.type_numeric() }}) as result
            from {{ ref(spec['model_name']) }}
            {% if not loop.last %}union all{% endif %}
        {% endfor %}
    ),
    formatted_metrics as (
        select
              cast(lpad(cast(metric_manifest.sort_order as {{ dbt.type_string() }}), 4, '0') as {{ dbt.type_string() }}) as id
            , cast(unioned_metrics.data_source as {{ dbt.type_string() }}) as data_source
            , cast(unioned_metrics.category as {{ dbt.type_string() }}) as category
            , cast(unioned_metrics.metric as {{ dbt.type_string() }}) as metric
            , cast(
                case
                    when unioned_metrics.result is null then null
                    when metric_manifest.result_type = 'count'
                        then cast(
                            {{ dq_analytical_count_result_sql('unioned_metrics.result') }}
                            as {{ dbt.type_string() }}
                        )
                    else rtrim(
                        rtrim(
                            cast(
                                {{ dq_analytical_decimal_result_sql('unioned_metrics.result') }}
                                as {{ dbt.type_string() }}
                            ),
                            '0'
                        ),
                        '.'
                    )
                end as {{ dbt.type_string() }}
              ) as result
        from unioned_metrics
        inner join metric_manifest
            on unioned_metrics.model_name = metric_manifest.model_name
    ),
    medicare_ffs_reference as (
        select
              cast(id as {{ dbt.type_string() }}) as id
            , cast(result as {{ dbt.type_string() }}) as medicare_ffs
        from {{ ref('data_quality__analytical_key_metrics_medicare_lds') }}
    ),
    tuva_synthetic_reference as (
        select
              cast(id as {{ dbt.type_string() }}) as id
            , cast(result as {{ dbt.type_string() }}) as tuva_synthetic
        from {{ ref('data_quality__analytical_key_metrics_tuva_synthetic_large') }}
    )
    select
          formatted_metrics.id
        , formatted_metrics.data_source
        , formatted_metrics.category
        , formatted_metrics.metric
        , formatted_metrics.result
        , medicare_ffs_reference.medicare_ffs
        , tuva_synthetic_reference.tuva_synthetic
    from formatted_metrics
    left join medicare_ffs_reference
        on formatted_metrics.id = medicare_ffs_reference.id
    left join tuva_synthetic_reference
        on formatted_metrics.id = tuva_synthetic_reference.id
    order by formatted_metrics.id, formatted_metrics.data_source
{% else %}
    {{ dq_analytical_empty_summary_result_sql() }}
{% endif %}
