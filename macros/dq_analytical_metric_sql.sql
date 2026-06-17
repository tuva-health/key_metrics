{% macro dq_analytical_metric_select_sql(source_relation, category, metric, metric_sql, result_expression='metric_results.result') %}
    select
          cast(sources.data_source as {{ dbt.type_string() }}) as data_source
        , cast({{ dq_analytical_string_literal(category) }} as {{ dbt.type_string() }}) as category
        , cast({{ dq_analytical_string_literal(metric) }} as {{ dbt.type_string() }}) as metric
        , cast({{ result_expression }} as {{ dbt.type_numeric() }}) as result
    from (
        {{ key_metrics_source_dimension_sql(source_relation) }}
    ) as sources
    left join (
        {{ metric_sql }}
    ) as metric_results
        on sources.data_source_key = metric_results.data_source_key
{% endmacro %}

{% macro dq_analytical_metric_null_rows_sql(source_relation, category, metric) %}
    select
          cast(sources.data_source as {{ dbt.type_string() }}) as data_source
        , cast({{ dq_analytical_string_literal(category) }} as {{ dbt.type_string() }}) as category
        , cast({{ dq_analytical_string_literal(metric) }} as {{ dbt.type_string() }}) as metric
        , cast(null as {{ dbt.type_numeric() }}) as result
    from (
        {{ key_metrics_source_dimension_sql(source_relation) }}
    ) as sources
{% endmacro %}

{% macro dq_analytical_encounter_visits_per_1000_sql(category, metric, encounter_type) %}
    {% set core_encounter_rel = dq_analytical_relation('core__encounter') %}
    {% set core_member_months_rel = dq_analytical_relation('core__member_month') %}

    {% if execute and core_encounter_rel is not none and core_member_months_rel is not none %}
        {% set metric_sql %}
            select
                  member_month_totals.data_source_key
                , case
                    when member_month_totals.member_months = 0 then 0
                    else (
                        cast(coalesce(encounter_counts.encounter_count, 0) as {{ dbt.type_numeric() }})
                        / cast(member_month_totals.member_months as {{ dbt.type_numeric() }})
                    ) * 12000
                  end as result
            from (
                select
                      coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                    , count(*) as member_months
                from {{ core_member_months_rel }}
                group by 1
            ) as member_month_totals
            left join (
                select
                      coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                    , count(*) as encounter_count
                from {{ core_encounter_rel }}
                where encounter_type = {{ dq_analytical_string_literal(encounter_type) }}
                group by 1
            ) as encounter_counts
                on member_month_totals.data_source_key = encounter_counts.data_source_key
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            core_member_months_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_encounter_count_sql(category, metric, encounter_type) %}
    {% set core_encounter_rel = dq_analytical_relation('core__encounter') %}

    {% if execute and core_encounter_rel is not none %}
        {% set metric_sql %}
            select
                  coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                , count(*) as result
            from {{ core_encounter_rel }}
            where encounter_type = {{ dq_analytical_string_literal(encounter_type) }}
            group by 1
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            core_encounter_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_encounter_days_per_1000_sql(category, metric, encounter_type) %}
    {% set core_encounter_rel = dq_analytical_relation('core__encounter') %}
    {% set core_member_months_rel = dq_analytical_relation('core__member_month') %}

    {% if execute and core_encounter_rel is not none and core_member_months_rel is not none %}
        {% set metric_sql %}
            select
                  member_month_totals.data_source_key
                , case
                    when member_month_totals.member_months = 0 then 0
                    else (
                        cast(coalesce(encounter_days.total_days, 0) as {{ dbt.type_numeric() }})
                        / cast(member_month_totals.member_months as {{ dbt.type_numeric() }})
                    ) * 12000
                  end as result
            from (
                select
                      coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                    , count(*) as member_months
                from {{ core_member_months_rel }}
                group by 1
            ) as member_month_totals
            left join (
                select
                      coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                    , coalesce(sum(length_of_stay), 0) as total_days
                from {{ core_encounter_rel }}
                where encounter_type = {{ dq_analytical_string_literal(encounter_type) }}
                group by 1
            ) as encounter_days
                on member_month_totals.data_source_key = encounter_days.data_source_key
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            core_member_months_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_encounter_average_length_of_stay_sql(category, metric, encounter_type) %}
    {% set core_encounter_rel = dq_analytical_relation('core__encounter') %}

    {% if execute and core_encounter_rel is not none %}
        {% set metric_sql %}
            select
                  coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                , avg(cast(length_of_stay as {{ dbt.type_numeric() }})) as result
            from {{ core_encounter_rel }}
            where encounter_type = {{ dq_analytical_string_literal(encounter_type) }}
            group by 1
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            core_encounter_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_encounter_average_paid_amount_sql(category, metric, encounter_type) %}
    {% set core_encounter_rel = dq_analytical_relation('core__encounter') %}

    {% if execute and core_encounter_rel is not none %}
        {% set metric_sql %}
            select
                  coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                , avg(cast(paid_amount as {{ dbt.type_numeric() }})) as result
            from {{ core_encounter_rel }}
            where encounter_type = {{ dq_analytical_string_literal(encounter_type) }}
            group by 1
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            core_encounter_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_acute_inpatient_mortality_rate_sql(category, metric) %}
    {% set core_encounter_rel = dq_analytical_relation('core__encounter') %}

    {% if execute and core_encounter_rel is not none %}
        {% set metric_sql %}
            select
                  coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                , case
                    when count(*) = 0 then 0
                    else (
                        cast(sum(
                            case
                                when discharge_disposition_code in ('20', '40', '41', '42') then 1
                                else 0
                            end
                        ) as {{ dbt.type_numeric() }})
                        / cast(count(*) as {{ dbt.type_numeric() }})
                    ) * 100
                  end as result
            from {{ core_encounter_rel }}
            where encounter_type = 'acute inpatient'
              and discharge_disposition_code is not null
              and encounter_end_date is not null
            group by 1
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            core_encounter_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_pmpm_metric_sql(category, metric, value_column) %}
    {% set financial_pmpm_rel = dq_analytical_relation('financial_pmpm__pmpm_prep') %}

    {% if execute and financial_pmpm_rel is not none %}
        {% set metric_sql %}
            select
                  coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                , avg(cast({{ key_metrics_quote_column(value_column) }} as {{ dbt.type_numeric() }})) as result
            from {{ financial_pmpm_rel }}
            group by 1
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            financial_pmpm_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_total_member_months_sql(category, metric) %}
    {% set core_member_months_rel = dq_analytical_relation('core__member_month') %}

    {% if execute and core_member_months_rel is not none %}
        {% set metric_sql %}
            select
                  coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                , count(*) as result
            from {{ core_member_months_rel }}
            group by 1
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            core_member_months_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_average_member_months_sql(category, metric) %}
    {% set core_member_months_rel = dq_analytical_relation('core__member_month') %}

    {% if execute and core_member_months_rel is not none %}
        {% set metric_sql %}
            select
                  patient_counts.data_source_key
                , avg(cast(patient_counts.member_month_count as {{ dbt.type_numeric() }})) as result
            from (
                select
                      coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                    , person_id
                    , count(*) as member_month_count
                from {{ core_member_months_rel }}
                group by 1, 2
            ) as patient_counts
            group by 1
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            core_member_months_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_max_member_months_sql(category, metric) %}
    {% set core_member_months_rel = dq_analytical_relation('core__member_month') %}

    {% if execute and core_member_months_rel is not none %}
        {% set metric_sql %}
            select
                  patient_counts.data_source_key
                , max(patient_counts.member_month_count) as result
            from (
                select
                      coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                    , person_id
                    , count(*) as member_month_count
                from {{ core_member_months_rel }}
                group by 1, 2
            ) as patient_counts
            group by 1
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            core_member_months_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_members_with_claims_without_enrollment_sql(category, metric) %}
    {% set core_medical_claim_rel = dq_analytical_relation('core__medical_claim') %}
    {% set core_pharmacy_claim_rel = dq_analytical_relation('core__pharmacy_claim') %}
    {% set core_eligibility_rel = dq_analytical_relation('core__eligibility') %}
    {% set claims_member_queries = [] %}

    {% if core_medical_claim_rel is not none %}
        {% set medical_claim_members_query %}
            select distinct
                  cast(data_source as {{ dbt.type_string() }}) as data_source
                , person_id
                , claim_start_date
                , coalesce(claim_end_date, claim_start_date) as claim_end_date
            from {{ core_medical_claim_rel }}
            where person_id is not null
              and claim_start_date is not null
        {% endset %}
        {% do claims_member_queries.append(medical_claim_members_query) %}
    {% endif %}

    {% if core_pharmacy_claim_rel is not none %}
        {% set pharmacy_claim_members_query %}
            select distinct
                  cast(data_source as {{ dbt.type_string() }}) as data_source
                , person_id
                , dispensing_date as claim_start_date
                , dispensing_date as claim_end_date
            from {{ core_pharmacy_claim_rel }}
            where person_id is not null
              and dispensing_date is not null
        {% endset %}
        {% do claims_member_queries.append(pharmacy_claim_members_query) %}
    {% endif %}

    {% if execute and claims_member_queries | length > 0 and core_eligibility_rel is not none %}
        select
              sources.data_source
            , cast({{ dq_analytical_string_literal(category) }} as {{ dbt.type_string() }}) as category
            , cast({{ dq_analytical_string_literal(metric) }} as {{ dbt.type_string() }}) as metric
            , cast({{ dq_analytical_count_result_sql("coalesce(missing_members.result, 0)") }} as {{ dbt.type_numeric() }}) as result
        from (
            select distinct
                  source_rows.data_source_key
                , source_rows.data_source
            from (
                {% if core_medical_claim_rel is not none and core_pharmacy_claim_rel is not none %}
                    {{ key_metrics_source_dimension_sql(core_medical_claim_rel) }}
                    union all
                    {{ key_metrics_source_dimension_sql(core_pharmacy_claim_rel) }}
                {% elif core_medical_claim_rel is not none %}
                    {{ key_metrics_source_dimension_sql(core_medical_claim_rel) }}
                {% else %}
                    {{ key_metrics_source_dimension_sql(core_pharmacy_claim_rel) }}
                {% endif %}
            ) as source_rows
        ) as sources
        left join (
            select
                  claim_members.data_source_key
                , count(distinct claim_members.person_id) as result
            from (
                select
                      coalesce(data_source, '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                    , data_source
                    , person_id
                    , claim_start_date
                    , claim_end_date
                from (
                    {{ claims_member_queries | join('\nunion\n') }}
                ) as claim_members
            ) as claim_members
            left join (
                select
                      coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                    , person_id
                    , enrollment_start_date
                    , enrollment_end_date
                from {{ core_eligibility_rel }}
                where person_id is not null
                  and enrollment_start_date is not null
                  and enrollment_end_date is not null
            ) as enrollment_spans
                on claim_members.data_source_key = enrollment_spans.data_source_key
                and claim_members.person_id = enrollment_spans.person_id
                and claim_members.claim_start_date <= enrollment_spans.enrollment_end_date
                and claim_members.claim_end_date >= enrollment_spans.enrollment_start_date
            where enrollment_spans.person_id is null
            group by 1
        ) as missing_members
            on sources.data_source_key = missing_members.data_source_key
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_ed_classification_percentage_sql(category, metric, classification) %}
    {% set ed_classification_rel = dq_analytical_relation('ed_classification__summary') %}

    {% if execute and ed_classification_rel is not none %}
        {% set classification_condition %}
            {% if classification is none %}
                ed_classification_description is null
            {% else %}
                ed_classification_description = {{ dq_analytical_string_literal(classification) }}
            {% endif %}
        {% endset %}

        {% set metric_sql %}
            select
                  totals.data_source_key
                , case
                    when totals.total_encounters = 0 then 0
                    else (
                        cast(coalesce(classified.encounters, 0) as {{ dbt.type_numeric() }})
                        / cast(totals.total_encounters as {{ dbt.type_numeric() }})
                    ) * 100
                  end as result
            from (
                select
                      coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                    , count(*) as total_encounters
                from {{ ed_classification_rel }}
                group by 1
            ) as totals
            left join (
                select
                      coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                    , count(*) as encounters
                from {{ ed_classification_rel }}
                where {{ classification_condition }}
                group by 1
            ) as classified
                on totals.data_source_key = classified.data_source_key
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            ed_classification_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_patient_count_sql(category, metric, where_sql=none) %}
    {% set core_patient_rel = dq_analytical_relation('core__patient') %}

    {% if execute and core_patient_rel is not none %}
        {% set metric_sql %}
            select
                  coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                , count(distinct person_id) as result
            from {{ core_patient_rel }}
            {% if where_sql is not none %}
            where {{ where_sql }}
            {% endif %}
            group by 1
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            core_patient_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_patient_percentage_sql(category, metric, where_sql) %}
    {% set core_patient_rel = dq_analytical_relation('core__patient') %}

    {% if execute and core_patient_rel is not none %}
        {% set metric_sql %}
            select
                  patient_totals.data_source_key
                , case
                    when patient_totals.total_patients = 0 then 0
                    else (
                        cast(coalesce(numerator_patients.patient_count, 0) as {{ dbt.type_numeric() }})
                        / cast(patient_totals.total_patients as {{ dbt.type_numeric() }})
                    ) * 100
                  end as result
            from (
                select
                      coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                    , count(distinct person_id) as total_patients
                from {{ core_patient_rel }}
                group by 1
            ) as patient_totals
            left join (
                select
                      coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                    , count(distinct person_id) as patient_count
                from {{ core_patient_rel }}
                where {{ where_sql }}
                group by 1
            ) as numerator_patients
                on patient_totals.data_source_key = numerator_patients.data_source_key
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            core_patient_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_deceased_patient_count_sql(category, metric) %}
    {% set core_patient_rel = dq_analytical_relation('core__patient') %}
    {% set core_encounter_rel = dq_analytical_relation('core__encounter') %}
    {% set deceased_patient_queries = [] %}

    {% if core_patient_rel is not none %}
        {% set patient_deceased_query %}
            select
                  coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                , person_id
            from {{ core_patient_rel }}
            where death_flag = 1
        {% endset %}
        {% do deceased_patient_queries.append(patient_deceased_query) %}
    {% endif %}

    {% if core_encounter_rel is not none %}
        {% set encounter_deceased_query %}
            select
                  coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                , person_id
            from {{ core_encounter_rel }}
            where discharge_disposition_code = '20'
        {% endset %}
        {% do deceased_patient_queries.append(encounter_deceased_query) %}
    {% endif %}

    {% if execute and core_patient_rel is not none and deceased_patient_queries | length > 0 %}
        {% set metric_sql %}
            select
                  patient_totals.data_source_key
                , case
                    when patient_totals.total_patients = 0 then 0
                    else (
                        cast(coalesce(deceased_patient_counts.patient_count, 0) as {{ dbt.type_numeric() }})
                        / cast(patient_totals.total_patients as {{ dbt.type_numeric() }})
                    ) * 100
                  end as result
            from (
                select
                      coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                    , count(distinct person_id) as total_patients
                from {{ core_patient_rel }}
                group by 1
            ) as patient_totals
            left join (
                select
                      deceased_patients.data_source_key
                    , count(distinct deceased_patients.person_id) as patient_count
                from (
                    {{ deceased_patient_queries | join('\nunion\n') }}
                ) as deceased_patients
                where deceased_patients.person_id is not null
                group by 1
            ) as deceased_patient_counts
                on patient_totals.data_source_key = deceased_patient_counts.data_source_key
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            core_patient_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_patient_age_range_count_sql(category, metric, min_age, max_age=none) %}
    {% if max_age is none %}
        {% set where_sql = "age >= " ~ min_age %}
    {% else %}
        {% set where_sql = "age between " ~ min_age ~ " and " ~ max_age %}
    {% endif %}

    {{ dq_analytical_patient_percentage_sql(
        category,
        metric,
        where_sql
    ) }}
{% endmacro %}

{% macro dq_analytical_patient_sex_count_sql(category, metric, sex_value) %}
    {{ dq_analytical_patient_percentage_sql(
        category,
        metric,
        "lower(cast(sex as " ~ dbt.type_string() ~ ")) = " ~ dq_analytical_string_literal(sex_value)
    ) }}
{% endmacro %}

{% macro dq_analytical_readmissions_acute_inpatient_visits_sql(metric) %}
    {{ dq_analytical_patient_count_sql('Readmissions', metric, "1 = 0") }}
{% endmacro %}

{% macro dq_analytical_acute_inpatient_count_sql(category, metric) %}
    {% set core_encounter_rel = dq_analytical_relation('core__encounter') %}

    {% if execute and core_encounter_rel is not none %}
        {% set metric_sql %}
            select
                  coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                , count(*) as result
            from {{ core_encounter_rel }}
            where encounter_type = 'acute inpatient'
            group by 1
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            core_encounter_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_readmissions_summary_count_sql(category, metric, flag_expression) %}
    {% set readmission_summary_rel = dq_analytical_relation('readmissions__readmission_summary') %}
    {% set readmission_augmented_rel = dq_analytical_relation('readmissions__encounter_augmented') %}

    {% if execute and readmission_summary_rel is not none and readmission_augmented_rel is not none %}
        {% set metric_sql %}
            select
                  coalesce(cast(augmented.data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                , sum(case when {{ flag_expression }} then 1 else 0 end) as result
            from {{ readmission_summary_rel }} as summary
            inner join {{ readmission_augmented_rel }} as augmented
                on summary.encounter_id = augmented.encounter_id
            group by 1
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            readmission_augmented_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_readmissions_rate_sql(category, metric, numerator_expression) %}
    {% set readmission_summary_rel = dq_analytical_relation('readmissions__readmission_summary') %}
    {% set readmission_augmented_rel = dq_analytical_relation('readmissions__encounter_augmented') %}

    {% if execute and readmission_summary_rel is not none and readmission_augmented_rel is not none %}
        {% set metric_sql %}
            select
                  readmission_counts.data_source_key
                , case
                    when readmission_counts.index_admissions = 0 then 0
                    else (
                        cast(readmission_counts.numerator as {{ dbt.type_numeric() }})
                        / cast(readmission_counts.index_admissions as {{ dbt.type_numeric() }})
                    ) * 100
                  end as result
            from (
                select
                      coalesce(cast(augmented.data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                    , sum(case when summary.index_admission_flag = 1 then 1 else 0 end) as index_admissions
                    , sum(case when {{ numerator_expression }} then 1 else 0 end) as numerator
                from {{ readmission_summary_rel }} as summary
                inner join {{ readmission_augmented_rel }} as augmented
                    on summary.encounter_id = augmented.encounter_id
                group by 1
            ) as readmission_counts
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            readmission_augmented_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_rate_of_index_admissions_sql(category, metric) %}
    {% set core_encounter_rel = dq_analytical_relation('core__encounter') %}
    {% set readmission_summary_rel = dq_analytical_relation('readmissions__readmission_summary') %}
    {% set readmission_augmented_rel = dq_analytical_relation('readmissions__encounter_augmented') %}

    {% if execute and core_encounter_rel is not none and readmission_summary_rel is not none and readmission_augmented_rel is not none %}
        {% set metric_sql %}
            select
                  acute_inpatient_counts.data_source_key
                , case
                    when acute_inpatient_counts.acute_inpatient_visits = 0 then 0
                    else (
                        cast(coalesce(index_counts.index_admissions, 0) as {{ dbt.type_numeric() }})
                        / cast(acute_inpatient_counts.acute_inpatient_visits as {{ dbt.type_numeric() }})
                    ) * 100
                  end as result
            from (
                select
                      coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                    , count(*) as acute_inpatient_visits
                from {{ core_encounter_rel }}
                where encounter_type = 'acute inpatient'
                group by 1
            ) as acute_inpatient_counts
            left join (
                select
                      coalesce(cast(augmented.data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                    , sum(case when summary.index_admission_flag = 1 then 1 else 0 end) as index_admissions
                from {{ readmission_summary_rel }} as summary
                inner join {{ readmission_augmented_rel }} as augmented
                    on summary.encounter_id = augmented.encounter_id
                group by 1
            ) as index_counts
                on acute_inpatient_counts.data_source_key = index_counts.data_source_key
        {% endset %}

        {{ dq_analytical_metric_select_sql(
            core_encounter_rel,
            category,
            metric,
            metric_sql,
            "coalesce(metric_results.result, 0)"
        ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_chronic_condition_prevalence_sql(category, metric, condition_family, source_condition_name) %}
    {% set core_patient_rel = dq_analytical_relation('core__patient') %}
    {% set core_condition_rel = dq_analytical_relation('core__condition') %}

    {% if execute and core_patient_rel is not none and core_condition_rel is not none %}
            {% set metric_sql %}
                select
                      patient_totals.data_source_key
                    , case
                        when patient_totals.total_patients = 0 then null
                        else (
                            cast(coalesce(condition_counts.patient_count, 0) as {{ dbt.type_numeric() }})
                            / cast(patient_totals.total_patients as {{ dbt.type_numeric() }})
                        ) * 100
                      end as result
                from (
                    select
                          coalesce(cast(data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                        , count(distinct person_id) as total_patients
                    from {{ core_patient_rel }}
                    group by 1
                ) as patient_totals
                left join (
                    select
                          coalesce(cast(patient.data_source as {{ dbt.type_string() }}), '{{ key_metrics_source_key_sentinel() }}') as data_source_key
                        , count(distinct patient.person_id) as patient_count
                    from {{ core_condition_rel }} as conditions
                    inner join {{ core_patient_rel }} as patient
                        on conditions.person_id = patient.person_id
                       and conditions.data_source = patient.data_source
                    where conditions.condition_family = {{ dq_analytical_string_literal(condition_family) }}
                      and conditions.condition = {{ dq_analytical_string_literal(source_condition_name) }}
                    group by 1
                ) as condition_counts
                    on patient_totals.data_source_key = condition_counts.data_source_key
            {% endset %}

            {{ dq_analytical_metric_select_sql(
                core_patient_rel,
                category,
                metric,
                metric_sql,
                "metric_results.result"
            ) }}
    {% else %}
        {{ dq_analytical_empty_result_sql() }}
    {% endif %}
{% endmacro %}

{% macro dq_analytical_metric_model_sql(model_name) %}
    {% set spec = dq_analytical_metric_spec(model_name) %}
    {% set family = spec['family'] %}

    {% if family == 'encounter_visits_per_1000' %}
        {{ dq_analytical_encounter_visits_per_1000_sql(spec['category'], spec['metric'], spec['encounter_type']) }}
    {% elif family == 'encounter_count' %}
        {{ dq_analytical_encounter_count_sql(spec['category'], spec['metric'], spec['encounter_type']) }}
    {% elif family == 'encounter_days_per_1000' %}
        {{ dq_analytical_encounter_days_per_1000_sql(spec['category'], spec['metric'], spec['encounter_type']) }}
    {% elif family == 'encounter_average_length_of_stay' %}
        {{ dq_analytical_encounter_average_length_of_stay_sql(spec['category'], spec['metric'], spec['encounter_type']) }}
    {% elif family == 'acute_inpatient_mortality_rate' %}
        {{ dq_analytical_acute_inpatient_mortality_rate_sql(spec['category'], spec['metric']) }}
    {% elif family == 'encounter_average_paid_amount' %}
        {{ dq_analytical_encounter_average_paid_amount_sql(spec['category'], spec['metric'], spec['encounter_type']) }}
    {% elif family == 'pmpm' %}
        {{ dq_analytical_pmpm_metric_sql(spec['category'], spec['metric'], spec['value_column']) }}
    {% elif family == 'total_member_months' %}
        {{ dq_analytical_total_member_months_sql(spec['category'], spec['metric']) }}
    {% elif family == 'members_with_claims_without_enrollment' %}
        {{ dq_analytical_members_with_claims_without_enrollment_sql(spec['category'], spec['metric']) }}
    {% elif family == 'average_member_months' %}
        {{ dq_analytical_average_member_months_sql(spec['category'], spec['metric']) }}
    {% elif family == 'max_member_months' %}
        {{ dq_analytical_max_member_months_sql(spec['category'], spec['metric']) }}
    {% elif family == 'ed_classification_percentage' %}
        {{ dq_analytical_ed_classification_percentage_sql(spec['category'], spec['metric'], spec['classification']) }}
    {% elif family == 'patient_count' %}
        {% if spec.get('where_sql') is not none %}
            {{ dq_analytical_patient_count_sql(spec['category'], spec['metric'], spec['where_sql']) }}
        {% else %}
            {{ dq_analytical_patient_count_sql(spec['category'], spec['metric']) }}
        {% endif %}
    {% elif family == 'deceased_patient_count' %}
        {{ dq_analytical_deceased_patient_count_sql(spec['category'], spec['metric']) }}
    {% elif family == 'patient_age_range_count' %}
        {{ dq_analytical_patient_age_range_count_sql(spec['category'], spec['metric'], spec['min_age'], spec['max_age']) }}
    {% elif family == 'patient_sex_count' %}
        {{ dq_analytical_patient_sex_count_sql(spec['category'], spec['metric'], spec['sex']) }}
    {% elif family == 'acute_inpatient_count' %}
        {{ dq_analytical_acute_inpatient_count_sql(spec['category'], spec['metric']) }}
    {% elif family == 'readmissions_summary_count' %}
        {{ dq_analytical_readmissions_summary_count_sql(spec['category'], spec['metric'], spec['flag_expression']) }}
    {% elif family == 'readmissions_rate' %}
        {{ dq_analytical_readmissions_rate_sql(spec['category'], spec['metric'], spec['numerator_expression']) }}
    {% elif family == 'rate_of_index_admissions' %}
        {{ dq_analytical_rate_of_index_admissions_sql(spec['category'], spec['metric']) }}
    {% elif family == 'chronic_condition_prevalence' %}
        {{ dq_analytical_chronic_condition_prevalence_sql(spec['category'], spec['metric'], spec['condition_family'], spec['source_condition']) }}
    {% else %}
        {{ exceptions.raise_compiler_error('Unsupported analytical metric family: ' ~ family ~ ' for ' ~ model_name) }}
    {% endif %}
{% endmacro %}
