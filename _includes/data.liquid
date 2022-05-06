{%- comment %}
*
*  collect feed
*
{% endcomment %}{% if page.redirect.from %}{% assign my_slug = page.redirect.from | split: '/' | last | split: '.' | first | prepend: '/' %}{% assign feed = site.feeds | where_exp:'item', 'item.path contains my_slug' %}{% assign my_feed = feed[0] %}{% else %}{% assign my_feed = page %}{% endif %}
{%- comment %}
*
*  collect hash
*
{% endcomment %}{% assign my_data = site.data %}{% assign my_datas = '' | split: ',' %}{% assign my_hash = my_feed.path | remove_first: '_' | split: '/' | pop %}{% for hash in my_hash %}{% assign _hash = hash | prepend: '_' %}{% assign my_data = my_data[_hash] %}{% assign my_datas = my_datas | push: my_data %}{% endfor %}
{%- comment %}
*
*  collect data
*
{% endcomment %}{% if my_feed.myId > 114 %}{% assign myId = my_feed.myId | modulo: 100 %}{% else %}{% assign myId = my_feed.myId %}{% endif %}{% for hashs in my_datas %}{% for hash in hashs %}{% if hash[1].id == myId %}{% assign data = hash[1] %}{% endif %}{% endfor %}{%- endfor -%}{% if page.redirect.from or my_feed.path == 'feed.json' or my_feed.ext == '.json' %}{
{%- comment %}
*
*  collect item
*
{% endcomment %}
    {{ 'id' | jsonify }}: {% if data.id %}{{ data.id }}{% else %}{{ page.id }}{% assign my_content = content | remove: '[' | remove: ']'  | split: ',' %}{% assign my_count = '' | split: ',' %}{% for item in my_content %}{% assign citem = item | times: 1 %}{% assign my_count = my_count | push: citem %}{% endfor %}{% endif %},
{%- comment %}
*
*  collect json
*
{% endcomment %}
    {{ 'title' | jsonify }}: "{% if data.title %}{{ data.title | capitalize }} | {% endif %}Project Maps",
    {{ 'version' | jsonify }}: {{ 'https://jsonfeed.org/version/1.1' | jsonify }},
    {{ 'home_page_url' | jsonify }}: {{ '/' | absolute_url | jsonify }},
    {{ 'feed_url' | jsonify }}: {{ page.url | absolute_url | jsonify }},
    {{ 'description' | jsonify }}: {{ site.slogan | jsonify }},
    {{ 'user_comment' | jsonify }}: {{ 'This feed allows you to read the project mapping' | jsonify }},
    {{ 'items' | jsonify }}: [
{%- comment %}
*
*  collect root
*
{% endcomment %}{% assign my_roots = site.data.roots %}{% if my_feed.path != 'feed.json' %}
        {{ data.items[0] | jsonify }},{% assign my_pos = my_feed.pos | minus: 1 %}
        {"root": {{ my_roots[my_pos] | jsonify }}}
{%- if page.layout != 'feeds' %},{% else %}
    ]
}{%- endif %}{% endif %}{% endif -%}