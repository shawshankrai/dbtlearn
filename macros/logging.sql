{% macro dbt_logging() %}
  {{ log("debug message saves to log file, if true print on screen", info=True) }}
  {# log("debug message saves to log file, if true print on screen", info=True) #}
{% endmacro %}