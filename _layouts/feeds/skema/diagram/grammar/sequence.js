{% assign object_items = site.feeds | where_exp:"item", "item.ext == '.coffee'" %}
{% for item in object_items %}{{ item.content | jsonify }}{% endfor %}
