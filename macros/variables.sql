{% macro learn_variables() %}
  {% set a_variable = "variable Value" %}
  {{ log("HW " ~ a_variable, info=True) }}

  {{ log("dbt/project variable Hello Planet " ~ var("planet_name", "No planet name set") ~"!", info=True)}}
  {# bt run-operation learn_variables --vars '{planet_name: Saturn}' #}
{% endmacro %}