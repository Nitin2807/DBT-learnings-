{# ---- Jinja Demo: Variables, For-Loops & Conditionals in dbt ---- #}

{# 1. Set variables — simulating an incremental flag and a high-water mark #}
{% set inc_flag = true %}
{% set last_load = 3 %}

{# 2. Column list to select dynamically #}
{% set col_list = ["sales_id", "date_sk", "store_sk"] %}

select

    {# Loop through columns; add comma after each except the last #}
    {% for col in col_list %}
        {{ col }}{% if not loop.last %},{% endif %}

    {% endfor %}

from {{ ref('bronze_sales') }}

{# 3. Conditional WHERE — only applied when inc_flag is true #}
{% if inc_flag %}
    where date_sk > {{ last_load }}
{% endif %}
