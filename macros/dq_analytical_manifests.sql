{% macro dq_analytical_metric_manifest() %}
    {% set manifest_json %}
[
    {
        "sort_order": 1,
        "model_name": "data_quality__analytical_key_metric__count_of_patients",
        "metric": "Number Of Patients",
        "result_type": "count",
        "family": "patient_count",
        "category": "Demographics"
    },
    {
        "sort_order": 2,
        "model_name": "data_quality__analytical_key_metric__count_of_patients_deceased",
        "metric": "% Patients Deceased",
        "result_type": "decimal",
        "family": "deceased_patient_count",
        "category": "Demographics"
    },
    {
        "sort_order": 3,
        "model_name": "data_quality__analytical_key_metric__patient__age_0_1",
        "metric": "% Patients Aged 0-1",
        "result_type": "decimal",
        "family": "patient_age_range_count",
        "min_age": 0,
        "max_age": 1,
        "category": "Demographics"
    },
    {
        "sort_order": 4,
        "model_name": "data_quality__analytical_key_metric__patient__age_2_17",
        "metric": "% Patients Aged 2-17",
        "result_type": "decimal",
        "family": "patient_age_range_count",
        "min_age": 2,
        "max_age": 17,
        "category": "Demographics"
    },
    {
        "sort_order": 5,
        "model_name": "data_quality__analytical_key_metric__patient__age_18_40",
        "metric": "% Patients Aged 18-40",
        "result_type": "decimal",
        "family": "patient_age_range_count",
        "min_age": 18,
        "max_age": 40,
        "category": "Demographics"
    },
    {
        "sort_order": 6,
        "model_name": "data_quality__analytical_key_metric__patient__age_41_64",
        "metric": "% Patients Aged 41-64",
        "result_type": "decimal",
        "family": "patient_age_range_count",
        "min_age": 41,
        "max_age": 64,
        "category": "Demographics"
    },
    {
        "sort_order": 7,
        "model_name": "data_quality__analytical_key_metric__patient__age_65_80",
        "metric": "% Patients Aged 65-80",
        "result_type": "decimal",
        "family": "patient_age_range_count",
        "min_age": 65,
        "max_age": 80,
        "category": "Demographics"
    },
    {
        "sort_order": 8,
        "model_name": "data_quality__analytical_key_metric__patient__age_81_100",
        "metric": "% Patients Aged 81-100",
        "result_type": "decimal",
        "family": "patient_age_range_count",
        "min_age": 81,
        "max_age": 100,
        "category": "Demographics"
    },
    {
        "sort_order": 9,
        "model_name": "data_quality__analytical_key_metric__patient__age_101_plus",
        "metric": "% Patients Aged 101 And Greater",
        "result_type": "decimal",
        "family": "patient_age_range_count",
        "min_age": 101,
        "max_age": null,
        "category": "Demographics"
    },
    {
        "sort_order": 10,
        "model_name": "data_quality__analytical_key_metric__patient__sex_female",
        "metric": "% Patients -- Sex = Female",
        "result_type": "decimal",
        "family": "patient_sex_count",
        "sex": "female",
        "category": "Demographics"
    },
    {
        "sort_order": 11,
        "model_name": "data_quality__analytical_key_metric__patient__sex_male",
        "metric": "% Patients -- Sex = Male",
        "result_type": "decimal",
        "family": "patient_sex_count",
        "sex": "male",
        "category": "Demographics"
    },
    {
        "sort_order": 12,
        "model_name": "data_quality__analytical_key_metric__patient__sex_unknown",
        "metric": "% Patients -- Sex = Unknown",
        "result_type": "decimal",
        "family": "patient_sex_count",
        "sex": "unknown",
        "category": "Demographics"
    },
    {
        "sort_order": 13,
        "model_name": "data_quality__analytical_key_metric__total_member_months",
        "metric": "Total Member Months",
        "result_type": "count",
        "family": "total_member_months",
        "category": "Enrollment"
    },
    {
        "sort_order": 14,
        "model_name": "data_quality__analytical_key_metric__members_with_claims_without_enrollment",
        "metric": "Members With Claims Without Enrollment",
        "result_type": "count",
        "family": "members_with_claims_without_enrollment",
        "category": "Enrollment"
    },
    {
        "sort_order": 15,
        "model_name": "data_quality__analytical_key_metric__average_member_months",
        "metric": "Average Member Months",
        "result_type": "decimal",
        "family": "average_member_months",
        "category": "Enrollment"
    },
    {
        "sort_order": 16,
        "model_name": "data_quality__analytical_key_metric__max_member_months",
        "metric": "Max Member Months",
        "result_type": "count",
        "family": "max_member_months",
        "category": "Enrollment"
    },
    {
        "sort_order": 17,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__autoimmune_disease__crohns_disease",
        "category": "Chronic Disease",
        "metric": "% Autoimmune Disease -- Crohn's Disease",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Autoimmune Disease",
        "source_condition": "Crohn's Disease"
    },
    {
        "sort_order": 18,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__autoimmune_disease__lupus",
        "category": "Chronic Disease",
        "metric": "% Autoimmune Disease -- Lupus",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Autoimmune Disease",
        "source_condition": "Lupus"
    },
    {
        "sort_order": 19,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__autoimmune_disease__rheumatoid_arthritis",
        "category": "Chronic Disease",
        "metric": "% Autoimmune Disease -- Rheumatoid Arthritis",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Autoimmune Disease",
        "source_condition": "Rheumatoid Arthritis"
    },
    {
        "sort_order": 20,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__autoimmune_disease__type_1_diabetes",
        "category": "Chronic Disease",
        "metric": "% Autoimmune Disease -- Type 1 Diabetes",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Autoimmune Disease",
        "source_condition": "Type 1 Diabetes"
    },
    {
        "sort_order": 21,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__autoimmune_disease__ulcerative_colitis",
        "category": "Chronic Disease",
        "metric": "% Autoimmune Disease -- Ulcerative Colitis",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Autoimmune Disease",
        "source_condition": "Ulcerative Colitis"
    },
    {
        "sort_order": 22,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__cancer__breast_cancer",
        "category": "Chronic Disease",
        "metric": "% Cancer -- Breast Cancer",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Cancer",
        "source_condition": "Breast Cancer"
    },
    {
        "sort_order": 23,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__cancer__colorectal_cancer",
        "category": "Chronic Disease",
        "metric": "% Cancer -- Colorectal Cancer",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Cancer",
        "source_condition": "Colorectal Cancer"
    },
    {
        "sort_order": 24,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__cancer__lung_cancer",
        "category": "Chronic Disease",
        "metric": "% Cancer -- Lung Cancer",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Cancer",
        "source_condition": "Lung Cancer"
    },
    {
        "sort_order": 25,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__cardiovascular_disease__acute_myocardial_infarction",
        "category": "Chronic Disease",
        "metric": "% Cardiovascular Disease -- Acute Myocardial Infarction",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Cardiovascular Disease",
        "source_condition": "Acute Myocardial Infarction"
    },
    {
        "sort_order": 26,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__cardiovascular_disease__atherosclerosis",
        "category": "Chronic Disease",
        "metric": "% Cardiovascular Disease -- Atherosclerosis",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Cardiovascular Disease",
        "source_condition": "Atherosclerosis"
    },
    {
        "sort_order": 27,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__cardiovascular_disease__atrial_fibrillation",
        "category": "Chronic Disease",
        "metric": "% Cardiovascular Disease -- Atrial Fibrillation",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Cardiovascular Disease",
        "source_condition": "Atrial Fibrillation"
    },
    {
        "sort_order": 28,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__cardiovascular_disease__heart_failure",
        "category": "Chronic Disease",
        "metric": "% Cardiovascular Disease -- Heart Failure",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Cardiovascular Disease",
        "source_condition": "Heart Failure"
    },
    {
        "sort_order": 29,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__cardiovascular_disease__hypertension",
        "category": "Chronic Disease",
        "metric": "% Cardiovascular Disease -- Hypertension",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Cardiovascular Disease",
        "source_condition": "Hypertension"
    },
    {
        "sort_order": 30,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__cardiovascular_disease__stroke_transient_ischemic_attack",
        "category": "Chronic Disease",
        "metric": "% Cardiovascular Disease -- Stroke / Transient Ischemic Attack",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Cardiovascular Disease",
        "source_condition": "Stroke / Transient Ischemic Attack"
    },
    {
        "sort_order": 31,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__mental_health__anxiety",
        "category": "Chronic Disease",
        "metric": "% Mental Health -- Anxiety",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Mental Health",
        "source_condition": "Anxiety"
    },
    {
        "sort_order": 32,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__mental_health__attention_deficit_hyperactivity_disorder_adhd",
        "category": "Chronic Disease",
        "metric": "% Mental Health -- Attention-Deficit Hyperactivity Disorder (ADHD)",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Mental Health",
        "source_condition": "Attention-Deficit Hyperactivity Disorder (ADHD)"
    },
    {
        "sort_order": 33,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__mental_health__bipolar",
        "category": "Chronic Disease",
        "metric": "% Mental Health -- Bipolar",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Mental Health",
        "source_condition": "Bipolar"
    },
    {
        "sort_order": 34,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__mental_health__depression",
        "category": "Chronic Disease",
        "metric": "% Mental Health -- Depression",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Mental Health",
        "source_condition": "Depression"
    },
    {
        "sort_order": 35,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__mental_health__obsessive_compulsive_disorder_ocd",
        "category": "Chronic Disease",
        "metric": "% Mental Health -- Obsessive-Compulsive Disorder (OCD)",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Mental Health",
        "source_condition": "Obsessive-Compulsive Disorder (OCD)"
    },
    {
        "sort_order": 36,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__mental_health__personality_disorder",
        "category": "Chronic Disease",
        "metric": "% Mental Health -- Personality Disorder",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Mental Health",
        "source_condition": "Personality Disorder"
    },
    {
        "sort_order": 37,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__mental_health__post_traumatic_stress_disorder_ptsd",
        "category": "Chronic Disease",
        "metric": "% Mental Health -- Post-Traumatic Stress Disorder (PTSD)",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Mental Health",
        "source_condition": "Post-Traumatic Stress Disorder (PTSD)"
    },
    {
        "sort_order": 38,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__mental_health__schizophrenia",
        "category": "Chronic Disease",
        "metric": "% Mental Health -- Schizophrenia",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Mental Health",
        "source_condition": "Schizophrenia"
    },
    {
        "sort_order": 39,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__metabolic_disease__chronic_kidney_disease",
        "category": "Chronic Disease",
        "metric": "% Metabolic Disease -- Chronic Kidney Disease",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Metabolic Disease",
        "source_condition": "Chronic Kidney Disease"
    },
    {
        "sort_order": 40,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__metabolic_disease__hyperlipidemia",
        "category": "Chronic Disease",
        "metric": "% Metabolic Disease -- Hyperlipidemia",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Metabolic Disease",
        "source_condition": "Hyperlipidemia"
    },
    {
        "sort_order": 41,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__metabolic_disease__metabolic_syndrome",
        "category": "Chronic Disease",
        "metric": "% Metabolic Disease -- Metabolic Syndrome",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Metabolic Disease",
        "source_condition": "Metabolic Syndrome"
    },
    {
        "sort_order": 42,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__metabolic_disease__obesity",
        "category": "Chronic Disease",
        "metric": "% Metabolic Disease -- Obesity",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Metabolic Disease",
        "source_condition": "Obesity"
    },
    {
        "sort_order": 43,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__metabolic_disease__type_2_diabetes",
        "category": "Chronic Disease",
        "metric": "% Metabolic Disease -- Type 2 Diabetes",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Metabolic Disease",
        "source_condition": "Type 2 Diabetes"
    },
    {
        "sort_order": 44,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__neuro_degenerative_disease__alzheimers_disease",
        "category": "Chronic Disease",
        "metric": "% Neuro-degenerative Disease -- Alzheimer's Disease",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Neuro-degenerative Disease",
        "source_condition": "Alzheimer's Disease"
    },
    {
        "sort_order": 45,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__neuro_degenerative_disease__amyotrophic_lateral_sclerosis_als",
        "category": "Chronic Disease",
        "metric": "% Neuro-degenerative Disease -- Amyotrophic Lateral Sclerosis (ALS)",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Neuro-degenerative Disease",
        "source_condition": "Amyotrophic Lateral Sclerosis (ALS)"
    },
    {
        "sort_order": 46,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__neuro_degenerative_disease__dementia",
        "category": "Chronic Disease",
        "metric": "% Neuro-degenerative Disease -- Dementia",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Neuro-degenerative Disease",
        "source_condition": "Dementia"
    },
    {
        "sort_order": 47,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__neuro_degenerative_disease__multiple_sclerosis",
        "category": "Chronic Disease",
        "metric": "% Neuro-degenerative Disease -- Multiple Sclerosis",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Neuro-degenerative Disease",
        "source_condition": "Multiple Sclerosis"
    },
    {
        "sort_order": 48,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__neuro_degenerative_disease__muscular_dystrophy",
        "category": "Chronic Disease",
        "metric": "% Neuro-degenerative Disease -- Muscular Dystrophy",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Neuro-degenerative Disease",
        "source_condition": "Muscular Dystrophy"
    },
    {
        "sort_order": 49,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__neuro_degenerative_disease__parkinsons_disease",
        "category": "Chronic Disease",
        "metric": "% Neuro-degenerative Disease -- Parkinson's Disease",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Neuro-degenerative Disease",
        "source_condition": "Parkinson's Disease"
    },
    {
        "sort_order": 50,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__pulmonary_disease__asthma",
        "category": "Chronic Disease",
        "metric": "% Pulmonary Disease -- Asthma",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Pulmonary Disease",
        "source_condition": "Asthma"
    },
    {
        "sort_order": 51,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__pulmonary_disease__chronic_obstructive_pulmonary_disease_copd",
        "category": "Chronic Disease",
        "metric": "% Pulmonary Disease -- Chronic Obstructive Pulmonary Disease (COPD)",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Pulmonary Disease",
        "source_condition": "Chronic Obstructive Pulmonary Disease (COPD)"
    },
    {
        "sort_order": 52,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__pulmonary_disease__cystic_fibrosis",
        "category": "Chronic Disease",
        "metric": "% Pulmonary Disease -- Cystic Fibrosis",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Pulmonary Disease",
        "source_condition": "Cystic Fibrosis"
    },
    {
        "sort_order": 53,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__substance_use__alcohol",
        "category": "Chronic Disease",
        "metric": "% Substance Use -- Alcohol",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Substance Use",
        "source_condition": "Alcohol"
    },
    {
        "sort_order": 54,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__substance_use__cocaine",
        "category": "Chronic Disease",
        "metric": "% Substance Use -- Cocaine",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Substance Use",
        "source_condition": "Cocaine"
    },
    {
        "sort_order": 55,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__substance_use__opioid",
        "category": "Chronic Disease",
        "metric": "% Substance Use -- Opioid",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Substance Use",
        "source_condition": "Opioid"
    },
    {
        "sort_order": 56,
        "model_name": "data_quality__analytical_key_metric__chronic_disease__substance_use__tobacco",
        "category": "Chronic Disease",
        "metric": "% Substance Use -- Tobacco",
        "result_type": "decimal",
        "family": "chronic_condition_prevalence",
        "condition_family": "Substance Use",
        "source_condition": "Tobacco"
    },
    {
        "sort_order": 57,
        "model_name": "data_quality__analytical_key_metric__ed_total_visits",
        "metric": "Total Number Of ED Visits",
        "result_type": "count",
        "family": "encounter_count",
        "encounter_type": "emergency department",
        "category": "Acute Care -- Emergency"
    },
    {
        "sort_order": 58,
        "model_name": "data_quality__analytical_key_metric__ed_classification__alcohol_related",
        "metric": "% ED Visits -- Alcohol Related",
        "result_type": "decimal",
        "family": "ed_classification_percentage",
        "classification": "Alcohol Related",
        "category": "Acute Care -- Emergency"
    },
    {
        "sort_order": 59,
        "model_name": "data_quality__analytical_key_metric__ed_classification__emergent_ed_care_needed_not_preventable_avoidable",
        "metric": "% ED Visits -- Emergent, ED Care Needed, Not Preventable/Avoidable",
        "result_type": "decimal",
        "family": "ed_classification_percentage",
        "classification": "Emergent, ED Care Needed, Not Preventable/Avoidable",
        "category": "Acute Care -- Emergency"
    },
    {
        "sort_order": 60,
        "model_name": "data_quality__analytical_key_metric__ed_classification__emergent_ed_care_needed_preventable_avoidable",
        "metric": "% ED Visits -- Emergent, ED Care Needed, Preventable/Avoidable",
        "result_type": "decimal",
        "family": "ed_classification_percentage",
        "classification": "Emergent, ED Care Needed, Preventable/Avoidable",
        "category": "Acute Care -- Emergency"
    },
    {
        "sort_order": 61,
        "model_name": "data_quality__analytical_key_metric__ed_classification__emergent_primary_care_treatable",
        "metric": "% ED Visits -- Emergent, Primary Care Treatable",
        "result_type": "decimal",
        "family": "ed_classification_percentage",
        "classification": "Emergent, Primary Care Treatable",
        "category": "Acute Care -- Emergency"
    },
    {
        "sort_order": 62,
        "model_name": "data_quality__analytical_key_metric__ed_classification__injury",
        "metric": "% ED Visits -- Injury",
        "result_type": "decimal",
        "family": "ed_classification_percentage",
        "classification": "Injury",
        "category": "Acute Care -- Emergency"
    },
    {
        "sort_order": 63,
        "model_name": "data_quality__analytical_key_metric__ed_classification__mental_health_related",
        "metric": "% ED Visits -- Mental Health Related",
        "result_type": "decimal",
        "family": "ed_classification_percentage",
        "classification": "Mental Health Related",
        "category": "Acute Care -- Emergency"
    },
    {
        "sort_order": 64,
        "model_name": "data_quality__analytical_key_metric__ed_classification__non_emergent",
        "metric": "% ED Visits -- Non-Emergent",
        "result_type": "decimal",
        "family": "ed_classification_percentage",
        "classification": "Non-Emergent",
        "category": "Acute Care -- Emergency"
    },
    {
        "sort_order": 65,
        "model_name": "data_quality__analytical_key_metric__ed_classification__not_classified",
        "metric": "% ED Visits -- Not Classified",
        "result_type": "decimal",
        "family": "ed_classification_percentage",
        "classification": null,
        "category": "Acute Care -- Emergency"
    },
    {
        "sort_order": 66,
        "model_name": "data_quality__analytical_key_metric__ed_visits_per_1000_members",
        "metric": "ED Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "emergency department",
        "category": "Acute Care -- Emergency"
    },
    {
        "sort_order": 67,
        "model_name": "data_quality__analytical_key_metric__ed_average_cost_per_visit",
        "metric": "Average Cost Per Visit",
        "result_type": "decimal",
        "family": "encounter_average_paid_amount",
        "encounter_type": "emergency department",
        "category": "Acute Care -- Emergency"
    },
    {
        "sort_order": 68,
        "model_name": "data_quality__analytical_key_metric__acute_inpatient_visits_per_1000_members",
        "metric": "Inpatient Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "acute inpatient",
        "category": "Acute Care -- Inpatient"
    },
    {
        "sort_order": 69,
        "model_name": "data_quality__analytical_key_metric__acute_inpatient_days_per_1000_members",
        "metric": "Inpatient Days PKPY",
        "result_type": "decimal",
        "family": "encounter_days_per_1000",
        "encounter_type": "acute inpatient",
        "category": "Acute Care -- Inpatient"
    },
    {
        "sort_order": 70,
        "model_name": "data_quality__analytical_key_metric__acute_inpatient_average_length_of_stay",
        "metric": "Average Inpatient Length Of Stay",
        "result_type": "decimal",
        "family": "encounter_average_length_of_stay",
        "encounter_type": "acute inpatient",
        "category": "Acute Care -- Inpatient"
    },
    {
        "sort_order": 71,
        "model_name": "data_quality__analytical_key_metric__acute_inpatient_mortality_rate",
        "metric": "% Mortality Rate",
        "result_type": "decimal",
        "family": "acute_inpatient_mortality_rate",
        "category": "Acute Care -- Inpatient"
    },
    {
        "sort_order": 72,
        "model_name": "data_quality__analytical_key_metric__acute_inpatient_average_cost_per_visit",
        "metric": "Average Cost Per Visit",
        "result_type": "decimal",
        "family": "encounter_average_paid_amount",
        "encounter_type": "acute inpatient",
        "category": "Acute Care -- Inpatient"
    },
    {
        "sort_order": 73,
        "model_name": "data_quality__analytical_key_metric__number_of_acute_inpatient_visits",
        "metric": "Number Of Acute Inpatient Visits",
        "result_type": "count",
        "family": "acute_inpatient_count",
        "category": "Readmissions"
    },
    {
        "sort_order": 74,
        "model_name": "data_quality__analytical_key_metric__number_of_index_admissions",
        "metric": "Number Of Index Admissions",
        "result_type": "count",
        "family": "readmissions_summary_count",
        "flag_expression": "summary.index_admission_flag = 1",
        "category": "Readmissions"
    },
    {
        "sort_order": 75,
        "model_name": "data_quality__analytical_key_metric__number_of_30_day_readmissions",
        "metric": "Number Of 30-Day Readmissions",
        "result_type": "count",
        "family": "readmissions_summary_count",
        "flag_expression": "summary.readmit_30_flag = 1",
        "category": "Readmissions"
    },
    {
        "sort_order": 76,
        "model_name": "data_quality__analytical_key_metric__number_of_30_day_unplanned_readmissions",
        "metric": "Number Of 30-Day Unplanned Readmissions",
        "result_type": "count",
        "family": "readmissions_summary_count",
        "flag_expression": "summary.unplanned_readmit_30_flag = 1",
        "category": "Readmissions"
    },
    {
        "sort_order": 77,
        "model_name": "data_quality__analytical_key_metric__rate_of_index_admissions",
        "metric": "% Index Admissions",
        "result_type": "decimal",
        "family": "rate_of_index_admissions",
        "category": "Readmissions"
    },
    {
        "sort_order": 78,
        "model_name": "data_quality__analytical_key_metric__rate_of_30_day_all_cause_readmissions",
        "metric": "% 30-Day All-Cause Readmissions",
        "result_type": "decimal",
        "family": "readmissions_rate",
        "numerator_expression": "summary.readmit_30_flag = 1",
        "category": "Readmissions"
    },
    {
        "sort_order": 79,
        "model_name": "data_quality__analytical_key_metric__rate_of_30_day_unplanned_readmissions",
        "metric": "% 30-Day Unplanned Readmissions",
        "result_type": "decimal",
        "family": "readmissions_rate",
        "numerator_expression": "summary.unplanned_readmit_30_flag = 1",
        "category": "Readmissions"
    },
    {
        "sort_order": 80,
        "model_name": "data_quality__analytical_key_metric__pmpm__total_paid",
        "metric": "Total PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "total_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 81,
        "model_name": "data_quality__analytical_key_metric__pmpm__medical_paid",
        "metric": "Total Medical PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "medical_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 82,
        "model_name": "data_quality__analytical_key_metric__pmpm__pharmacy_paid",
        "metric": "Total Pharmacy PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "pharmacy_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 83,
        "model_name": "data_quality__analytical_key_metric__pmpm__acute_inpatient_paid",
        "metric": "Inpatient -- Acute Inpatient PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "acute_inpatient_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 84,
        "model_name": "data_quality__analytical_key_metric__pmpm__inpatient_hospice_paid",
        "metric": "Inpatient -- Inpatient Hospice PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "inpatient_hospice_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 85,
        "model_name": "data_quality__analytical_key_metric__pmpm__inpatient_psychiatric_paid",
        "metric": "Inpatient -- Inpatient Psychiatric PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "inpatient_psychiatric_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 86,
        "model_name": "data_quality__analytical_key_metric__pmpm__inpatient_rehabilitation_paid",
        "metric": "Inpatient -- Inpatient Rehabilitation PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "inpatient_rehabilitation_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 87,
        "model_name": "data_quality__analytical_key_metric__pmpm__skilled_nursing_paid",
        "metric": "Inpatient -- Skilled Nursing PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "skilled_nursing_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 88,
        "model_name": "data_quality__analytical_key_metric__pmpm__ambulatory_surgery_center_paid",
        "metric": "Outpatient -- Ambulatory Surgery Center PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "ambulatory_surgery_center_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 89,
        "model_name": "data_quality__analytical_key_metric__pmpm__dialysis_paid",
        "metric": "Outpatient -- Dialysis PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "dialysis_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 90,
        "model_name": "data_quality__analytical_key_metric__pmpm__emergency_department_paid",
        "metric": "Outpatient -- Emergency Department PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "emergency_department_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 91,
        "model_name": "data_quality__analytical_key_metric__pmpm__home_health_paid",
        "metric": "Outpatient -- Home Health PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "home_health_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 92,
        "model_name": "data_quality__analytical_key_metric__pmpm__observation_paid",
        "metric": "Outpatient -- Observation PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "observation_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 93,
        "model_name": "data_quality__analytical_key_metric__pmpm__outpatient_hospice_paid",
        "metric": "Outpatient -- Outpatient Hospice PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "outpatient_hospice_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 94,
        "model_name": "data_quality__analytical_key_metric__pmpm__outpatient_hospital_or_clinic_paid",
        "metric": "Outpatient -- Outpatient Hospital Or Clinic PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "outpatient_hospital_or_clinic_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 95,
        "model_name": "data_quality__analytical_key_metric__pmpm__outpatient_pt_ot_st_paid",
        "metric": "Outpatient -- Outpatient PT/OT/ST PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "outpatient_pt_ot_st_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 96,
        "model_name": "data_quality__analytical_key_metric__pmpm__outpatient_psychiatric_paid",
        "metric": "Outpatient -- Outpatient Psychiatric PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "outpatient_psychiatric_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 97,
        "model_name": "data_quality__analytical_key_metric__pmpm__outpatient_radiology_paid",
        "metric": "Outpatient -- Outpatient Radiology PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "outpatient_radiology_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 98,
        "model_name": "data_quality__analytical_key_metric__pmpm__outpatient_rehabilitation_paid",
        "metric": "Outpatient -- Outpatient Rehabilitation PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "outpatient_rehabilitation_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 99,
        "model_name": "data_quality__analytical_key_metric__pmpm__outpatient_surgery_paid",
        "metric": "Outpatient -- Outpatient Surgery PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "outpatient_surgery_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 100,
        "model_name": "data_quality__analytical_key_metric__pmpm__urgent_care_paid",
        "metric": "Outpatient -- Urgent Care PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "urgent_care_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 101,
        "model_name": "data_quality__analytical_key_metric__pmpm__office_based_other_paid",
        "metric": "Office-Based -- Office-Based Other PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "office_based_other_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 102,
        "model_name": "data_quality__analytical_key_metric__pmpm__office_based_pt_ot_st_paid",
        "metric": "Office-Based -- Office-Based PT/OT/ST PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "office_based_pt_ot_st_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 103,
        "model_name": "data_quality__analytical_key_metric__pmpm__office_based_radiology_paid",
        "metric": "Office-Based -- Office-Based Radiology PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "office_based_radiology_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 104,
        "model_name": "data_quality__analytical_key_metric__pmpm__office_based_surgery_paid",
        "metric": "Office-Based -- Office-Based Surgery PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "office_based_surgery_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 105,
        "model_name": "data_quality__analytical_key_metric__pmpm__office_based_visit_paid",
        "metric": "Office-Based -- Office-Based Visit PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "office_based_visit_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 106,
        "model_name": "data_quality__analytical_key_metric__pmpm__telehealth_visit_paid",
        "metric": "Office-Based -- Telehealth Visit PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "telehealth_visit_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 107,
        "model_name": "data_quality__analytical_key_metric__pmpm__ambulance_paid",
        "metric": "Ancillary -- Ambulance PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "ambulance_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 108,
        "model_name": "data_quality__analytical_key_metric__pmpm__durable_medical_equipment_paid",
        "metric": "Ancillary -- Durable Medical Equipment PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "durable_medical_equipment_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 109,
        "model_name": "data_quality__analytical_key_metric__pmpm__lab_paid",
        "metric": "Ancillary -- Lab PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "lab_paid",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 110,
        "model_name": "data_quality__analytical_key_metric__pmpm__other_paid",
        "metric": "Other -- Other PMPM Paid",
        "result_type": "decimal",
        "family": "pmpm",
        "value_column": "other_paid_2",
        "category": "Financial PMPM"
    },
    {
        "sort_order": 111,
        "model_name": "data_quality__analytical_key_metric__encounter__inpatient_acute_inpatient",
        "metric": "Inpatient -- Acute Inpatient Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "acute inpatient",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 112,
        "model_name": "data_quality__analytical_key_metric__encounter__inpatient_inpatient_hospice",
        "metric": "Inpatient -- Inpatient Hospice Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "inpatient hospice",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 113,
        "model_name": "data_quality__analytical_key_metric__encounter__inpatient_inpatient_long_term_acute_care",
        "metric": "Inpatient -- Inpatient Long Term Acute Care Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "inpatient long term acute care",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 114,
        "model_name": "data_quality__analytical_key_metric__encounter__inpatient_inpatient_psych",
        "metric": "Inpatient -- Inpatient Psych Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "inpatient psych",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 115,
        "model_name": "data_quality__analytical_key_metric__encounter__inpatient_inpatient_rehabilitation",
        "metric": "Inpatient -- Inpatient Rehabilitation Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "inpatient rehabilitation",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 116,
        "model_name": "data_quality__analytical_key_metric__encounter__inpatient_inpatient_skilled_nursing",
        "metric": "Inpatient -- Inpatient Skilled Nursing Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "inpatient skilled nursing",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 117,
        "model_name": "data_quality__analytical_key_metric__encounter__inpatient_inpatient_substance_use",
        "metric": "Inpatient -- Inpatient Substance Use Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "inpatient substance use",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 118,
        "model_name": "data_quality__analytical_key_metric__encounter__outpatient_ambulatory_surgery_center",
        "metric": "Outpatient -- Ambulatory Surgery Center Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "ambulatory surgery center",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 119,
        "model_name": "data_quality__analytical_key_metric__encounter__outpatient_dialysis",
        "metric": "Outpatient -- Dialysis Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "dialysis",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 120,
        "model_name": "data_quality__analytical_key_metric__encounter__outpatient_emergency_department",
        "metric": "Outpatient -- Emergency Department Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "emergency department",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 121,
        "model_name": "data_quality__analytical_key_metric__encounter__outpatient_home_health",
        "metric": "Outpatient -- Home Health Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "home health",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 122,
        "model_name": "data_quality__analytical_key_metric__encounter__outpatient_outpatient_hospice",
        "metric": "Outpatient -- Outpatient Hospice Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "outpatient hospice",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 123,
        "model_name": "data_quality__analytical_key_metric__encounter__outpatient_outpatient_hospital_or_clinic",
        "metric": "Outpatient -- Outpatient Hospital Or Clinic Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "outpatient hospital or clinic",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 124,
        "model_name": "data_quality__analytical_key_metric__encounter__outpatient_outpatient_injections",
        "metric": "Outpatient -- Outpatient Injections Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "outpatient injections",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 125,
        "model_name": "data_quality__analytical_key_metric__encounter__outpatient_outpatient_psych",
        "metric": "Outpatient -- Outpatient Psych Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "outpatient psych",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 126,
        "model_name": "data_quality__analytical_key_metric__encounter__outpatient_outpatient_pt_ot_st",
        "metric": "Outpatient -- Outpatient PT/OT/ST Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "outpatient pt/ot/st",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 127,
        "model_name": "data_quality__analytical_key_metric__encounter__outpatient_outpatient_radiology",
        "metric": "Outpatient -- Outpatient Radiology Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "outpatient radiology",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 128,
        "model_name": "data_quality__analytical_key_metric__encounter__outpatient_outpatient_rehabilitation",
        "metric": "Outpatient -- Outpatient Rehabilitation Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "outpatient rehabilitation",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 129,
        "model_name": "data_quality__analytical_key_metric__encounter__outpatient_outpatient_substance_use",
        "metric": "Outpatient -- Outpatient Substance Use Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "outpatient substance use",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 130,
        "model_name": "data_quality__analytical_key_metric__encounter__outpatient_outpatient_surgery",
        "metric": "Outpatient -- Outpatient Surgery Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "outpatient surgery",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 131,
        "model_name": "data_quality__analytical_key_metric__encounter__outpatient_urgent_care",
        "metric": "Outpatient -- Urgent Care Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "urgent care",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 132,
        "model_name": "data_quality__analytical_key_metric__encounter__office_based_office_visit",
        "metric": "Office Based -- Office Visit Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "office visit",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 133,
        "model_name": "data_quality__analytical_key_metric__encounter__other_ambulance_orphaned",
        "metric": "Other -- Ambulance - Orphaned Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "ambulance - orphaned",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 134,
        "model_name": "data_quality__analytical_key_metric__encounter__other_dme_orphaned",
        "metric": "Other -- DME - Orphaned Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "dme - orphaned",
        "category": "Utilization PKPY"
    },
    {
        "sort_order": 135,
        "model_name": "data_quality__analytical_key_metric__encounter__other_lab_orphaned",
        "metric": "Other -- Lab - Orphaned Visits PKPY",
        "result_type": "decimal",
        "family": "encounter_visits_per_1000",
        "encounter_type": "lab - orphaned",
        "category": "Utilization PKPY"
    }
]
    {% endset %}

    {{ return(fromjson(manifest_json)) }}
{% endmacro %}
