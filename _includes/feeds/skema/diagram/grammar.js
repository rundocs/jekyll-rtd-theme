{% comment %}
*
*  This layout loops through a collection called `feeds` and collect site data 
*
*  You may see the running code here:
*  https://chetabahana.github.io/grammar.json
*  https://chetabahana.github.io/diagram/grammar.js
*
{% endcomment %}var Grammar = {

    feed : function(id, size) {

        {%- assign my_feed = site.feeds | where_exp:"item", "item.myId == myId" | first %}
        if (!data) feed = '/{{ my_feed.category }}/{{ my_feed.slug }}.json?t=' + $.now();
        draw.getJSON();

    }

}
