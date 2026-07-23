{% set apples = ["Gala", "Fuji", "Honeycrisp"," Granny Smith", "Red Delicious"] %}

{% for i in apples %}
    {%if i!= 'Fuji'%}
        {{ i }}
    {%else%}
        {{ i }} is my favorite apple!
    {%endif%}
{% endfor %}