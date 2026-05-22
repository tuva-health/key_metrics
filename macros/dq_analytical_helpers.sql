{% macro key_metrics_schema_name() %}
    {% if var('tuva_schema_prefix', None) is not none %}
        {{ return(var('tuva_schema_prefix', None) ~ '_key_metrics') }}
    {% endif %}

    {{ return('key_metrics') }}
{% endmacro %}

{% macro dq_data_quality_schema_name() %}
    {{ return(key_metrics_schema_name()) }}
{% endmacro %}

{% macro dq_config_analytical_metric_model(alias_name) %}
    {{ config(
         enabled = var('enable_key_metrics', true) | as_bool,
         schema = key_metrics_schema_name(),
         alias = alias_name,
         tags = ['key_metrics'],
         materialized = 'table'
       )
    }}
{% endmacro %}

{% macro dq_analytical_empty_result_sql() %}
    select
          cast(null as {{ dbt.type_string() }}) as data_source
        , cast(null as {{ dbt.type_string() }}) as category
        , cast(null as {{ dbt.type_string() }}) as metric
        , cast(null as {{ dbt.type_numeric() }}) as result
    {{ dq_empty_result_guard_sql() }}
{% endmacro %}

{% macro dq_analytical_empty_summary_result_sql() %}
    select
          cast(null as {{ dbt.type_string() }}) as id
        , cast(null as {{ dbt.type_string() }}) as data_source
        , cast(null as {{ dbt.type_string() }}) as category
        , cast(null as {{ dbt.type_string() }}) as metric
        , cast(null as {{ dbt.type_string() }}) as result
        , cast(null as {{ dbt.type_string() }}) as medicare_ffs
        , cast(null as {{ dbt.type_string() }}) as tuva_synthetic
    {{ dq_empty_result_guard_sql() }}
{% endmacro %}

{% macro dq_analytical_count_result_sql(result_expression) %}
    {{ return(
        "cast(round(cast(" ~ result_expression ~ " as " ~ dbt.type_numeric() ~ "), 0) as " ~ dbt.type_int() ~ ")"
    ) }}
{% endmacro %}

{% macro dq_analytical_decimal_result_sql(result_expression) %}
    {{ return(
        "cast(round(cast(" ~ result_expression ~ " as " ~ dbt.type_numeric() ~ "), 2) as " ~ dbt.type_numeric() ~ ")"
    ) }}
{% endmacro %}

{% macro dq_find_analytical_node(node_name) %}
    {% if not execute %}
        {{ return(none) }}
    {% endif %}

    {% set package_priority = [
        'key_metrics',
        'the_tuva_project',
        'quality_measures',
        'nyu_ed_classification',
        'cms_hcc',
        'fhir_preprocessing'
    ] %}

    {% for package_name in package_priority %}
        {% for graph_node in graph['nodes'].values() %}
            {% if graph_node.package_name == package_name
                  and graph_node.name == node_name
                  and graph_node.resource_type in ['model', 'seed'] %}
                {{ return(graph_node) }}
            {% endif %}
        {% endfor %}
    {% endfor %}

    {% for graph_node in graph['nodes'].values() %}
        {% if graph_node.name == node_name
              and graph_node.resource_type in ['model', 'seed'] %}
            {{ return(graph_node) }}
        {% endif %}
    {% endfor %}

    {{ return(none) }}
{% endmacro %}

{% macro dq_analytical_relation(model_name) %}
    {{ return(dq_actual_relation(dq_find_analytical_node(model_name))) }}
{% endmacro %}

{% macro dq_analytical_string_literal(value) %}
    {{ return("'" ~ (value | string | replace("'", "''")) ~ "'") }}
{% endmacro %}

{% macro dq_analytical_normalize_text_sql(expression) %}
    {{ return(
        "lower("
        ~ "replace("
        ~ "replace("
        ~ "replace("
        ~ "replace("
        ~ "replace("
        ~ "replace("
        ~ "replace("
        ~ "cast(" ~ expression ~ " as " ~ dbt.type_string() ~ ")"
        ~ ", ' ', '')"
        ~ ", '/', '')"
        ~ ", '-', '')"
        ~ ", ',', '')"
        ~ ", '(', '')"
        ~ ", ')', '')"
        ~ ", '.', '')"
        ~ ")"
    ) }}
{% endmacro %}

{% macro dq_analytical_key_metric_model_names() %}
    {% set model_names = [] %}

    {% for spec in dq_analytical_metric_manifest() %}
        {% do model_names.append(spec['model_name']) %}
    {% endfor %}

    {{ return(model_names) }}
{% endmacro %}

{% macro dq_analytical_metric_spec(model_name) %}
    {% for spec in dq_analytical_metric_manifest() %}
        {% if spec['model_name'] == model_name %}
            {{ return(spec) }}
        {% endif %}
    {% endfor %}

    {{ exceptions.raise_compiler_error('No analytical metric spec found for ' ~ model_name) }}
{% endmacro %}
