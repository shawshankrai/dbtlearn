{{
    config(
        materialized = 'incremental',
        on_schema_change='fail'
    )
}}
WITH src_reviews AS (
    SELECT * FROM {{ ref("src_reviews")}}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['LISTING_ID', 'REVIEW_DATE', 'REVIEW_TEXT']) }} as review_id,
    *
FROM src_reviews
WHERE review_text is not null
{% if is_incremental() %}
    {% if var("start_date", False) and var("end_date", False) %}
      
      {{ log('Loading ' ~ this ~ ' incrementally(start_date:' ~ var("start_date") ~', end_date: ' ~ var("end_date"), info=True) }}
      AND review_date >= '{{  var("start_date") }}'
      AND review_date < '{{  var("end_date") }}'

    {% else %}

        AND review_date > (SELECT max(review_date) FROM {{ this }} )
        {{ log('Loading ' ~ this ~ ' incrementally (all missing dates)', info=True) }}
        
    {% endif %}
{% endif %}