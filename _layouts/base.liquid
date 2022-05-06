{% comment %}
*
*  This loop loops through all collection called `feeds` with category 'section'
*  and sorts it by the front matter variable 'weight' and than render
*  each of the {{ output }} with their own layout
*
*  You may see the running code here:
*  https://chetabahana.github.io/feed.json
*
{% endcomment %}{% if data == null %}{% include data.rb %}{% endif %}{% assign my_base = site.basedir %}{% assign my_atributs = 'id, key, link, weight, title, next, content, output, previous, redirect_from, relative_path, collection, excerpt, category, categories, ext, layout, tags, path, url, draft, slug, pos, myId, type, primes, value, object, frame, ratio, pairs, zones' | split:', ' %}{% assign my_tab = '    ' %}{% assign my_path = '' | split: ',' %}{% comment %}
*
*  get the maximum size of feeds
*
{% endcomment %}{% assign my_size = 1 %}{% assign feeds = site.feeds | sort:0 %}{% for feed in feeds %}{% assign my_split = feed.path | split: '/' %}{% assign size = my_split | size %}{% if size > my_size %}{% assign my_path = my_path | push: size %}{% assign my_size = size %}{% endif %}{% endfor %}{% comment %}
*
*  sort feeds base on weight (reversed order)
*
{% endcomment %}{% assign feeds = site.feeds | sort: 'weight' %}{% assign my_paths = '' | split: ',' %}{% for my_size in my_path reversed %}{% for feed in feeds %}{% assign my_dir = feed.path | split: '/' | pop | join: '/' %}{% unless my_dir == my_base %}{% assign my_split = feed.path | split: '/' %}{% assign size = my_split | size %}{% if size == my_size %}{% assign my_paths = my_paths | push: feed %}{% endif %}{% endunless %}{% endfor %}{% endfor %}{% comment %}
*
*  capture each outputs
*
{% endcomment %}{% assign my_captures = '' | split: ',' %}{% for feed in my_paths %}{% assign my_split = feed.path | split: '/' %}{% assign my_path_size = my_split | size %}{% assign my_part = my_split | size | minus: 2 %}{% assign my_size = my_split | size | times: 2 | minus: 2 %}{% assign my_dir = my_split[my_part] | prepend: '/' | append: '/' %}{% assign my_title = feed.title | downcase | prepend: my_dir | append: '/' %}{% assign my_index = '' | split: ',' %}{% for my_push in my_paths %}{% assign my_num = my_push.path | split: '/' | size | minus: my_path_size %}{% if my_num == 1 and my_push.path contains my_title %}{% assign my_index = my_index | push: forloop.index0 %}{% endif %}{% endfor %}{% comment %}
*
*  index the feeds output
*
{% endcomment %}{% capture my_capture %}
{% if page.path != 'index.html' %}{% include items.rb %}{% endif %}{% for i in (1..my_size) %}{{ my_tab }}{% endfor %}}{% endcapture %}{% assign my_captures = my_captures | push: my_capture %}{% endfor %}{% assign my_feeds = '' | split: ',' %}{% for feed in feeds %}{% assign my_dir = feed.path | split: '/' | pop | join: '/' %}{% if my_dir == my_base %}{% assign my_feeds = my_feeds | push: feed %}{% endif %}{% endfor %}{% comment %}
*
*  collect the feeds output
*
{% endcomment %}{% for feed in my_feeds %}{% assign my_title = feed.title | downcase | prepend: '/' | prepend: my_base | append: '/' %}{% assign my_index = '' | split: ',' %}{% for my_path in my_paths %}{% assign my_split = my_path.path | split: '/' | size %}{% if my_split == 3 and my_path.path contains my_title %}{% assign my_index = my_index | push: forloop.index0 %}{% endif %}{% endfor %}{% comment %}
*
*  render the feeds output
*  JSON.pretty_generate(@data)
*
{% endcomment %}{% assign my_size = 2 %}{% if page.path == 'feed.json' %}
{% include items.rb %}{{ my_tab }}{{ my_tab }}}{% unless forloop.last %},{% endunless %}{% endif %}{% endfor %}{% if page.path != 'index.html' and page.ext != '.md' %}{% if page.layout == 'redirect' %}{% include leads.rb %}{% endif %}
{{ my_tab }}]
}
{% else %}{% comment %}
*
*  render the main page 
*
{% endcomment %}{{ content }}{% endif %}