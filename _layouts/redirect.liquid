---
layout: base
---
{% comment %}
*
*  This redirects are performed by serving a data file with an HTTP-REFRESH
*  meta tag which configured via variable {{ page.redirect.from }}
*  Ref: https://github.com/jekyll/jekyll-redirect-from
*
*  You may see the running code here:
*  https://chetabahana.github.io/sequence.json
*
*  jekyll debug or print json
*  https://docs.treepl.co/liquid
*  https://warfares.github.io/pretty-json/
*  https://github.com/chetabahana/code-prettify
*  https://stackoverflow.com/a/41646032/4058484
*  https://stackoverflow.com/q/34048313/4058484
*  https://avada.io/shopify/devdocs/how-to-convert-jekyll-data-to-json.html
*
*  # var1 = "a"     // string
*  {% var1.first %} // return:   // nil -> falsy
*  
*  # var2 = [a,b,c] // array
*  {% var2.first %} // return: a
*  
*  # var3 = {k1: a, k2: b, k3: c} // hash
*  {% var1.first %} // return: k1a
*  
*  # var4 = {k1, k2, k3: c} // hash, first element is a key without associated value
*  {% var1.first %} // return: k1
*
{% endcomment %}{% include data.liquid %}{% assign variable = data.items[0] -%}
    {%- assign my_tabs = 2 %}{%- assign my_tab = '    ' -%}
    {%- capture my_tabs %}{% for i in (1..my_tabs) %}{{ my_tab }}{% endfor %}{% endcapture -%}
    {%- if variable == null %}{{- my_tabs }}{{ data | jsonify }}{% else %}{% capture my_tabn %}
    {{ my_tabs }}{% endcapture -%}{{- my_tabs }}{
    {%- for items in variable -%}{{ items.first }}
        {%- if items.first == null -%}
            {{- my_tabn }}ss{{ items[0] | jsonify }}: {{ items[1] | jsonify }}
        {%- else -%}
            {%- for item in items -%}
                {%- if item[0] -%}
                    {%- for subitem in item -%}
                        {%- if subitem[0] -%}
                             {{- my_tabn }}aa{{ subitem | jsonify }}
                        {%- else -%}
                             {{- my_tabn }}as{{ subitem | jsonify }}
                        {%- endif -%}
                    {%- endfor -%}
                {%- else -%}
{%- comment -%}
                    {%- for prop in item -%}
                        {%- if forloop.first -%}
                            {{- my_tabn }}{{ prop | jsonify }}: {
                        {%- else -%}
                            {{- my_tabn }}{{ my_tab }}{{ prop[0] | jsonify}}: {{ prop[1] | jsonify -}}
                            {%- unless forloop.last %},{% endunless -%}
                            {%- if forloop.last %}{{- my_tabn }}}{% endif -%}
                        {%- endif -%}
                    {%- endfor -%}

{%- endcomment -%}
                    {{- my_tabn }}sa{{ item | jsonify }}
                {%- endif -%}
            {%- endfor -%}
        {%- endif %}{% unless forloop.last %},{% endunless -%}
    {%- endfor %}
{{ my_tabs }}}
{%- endif -%}
