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
  AND review_date > (SELECT max(review_date) FROM {{ this }})
{% endif %}