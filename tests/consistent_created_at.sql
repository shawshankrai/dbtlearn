-- Singular test
SELECT
    *
FROM
    {{ ref("fct_reviews") }} as f
JOIN
    {{ ref("dim_listings_cleansed") }} as l ON f.listing_id = l.listing_id
WHERE
    f.review_date <= l.created_at