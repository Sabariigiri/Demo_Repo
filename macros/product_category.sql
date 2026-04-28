{% macro product_category(category_code) %}
case
  when {{ category_code }} = 1 then 'Snacks'
  when {{ category_code }} = 2 then 'Cereal'
  else 'Other'
end
{% endmacro %}