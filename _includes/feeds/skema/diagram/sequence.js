{% comment %}
*
*  This layout loops through a collection called `feeds` and collect site data 
*
*  You may see the running code here:
*  https://chetabahana.github.io/sequence.json
*  https://chetabahana.github.io/diagram/sequence.js
*
*  Here we are defining The Document Object Model (DOM) with JavaScript
*  as the relations between their nodes with our feeds object.
*
*  You may see the reference of the code here:
*  https://javascript.plainenglish.io/how-to-traverse-the-dom-in-javascript-d6555c335b4e
*
{% endcomment %}var Sequence = {

    feed : function(id, size) {

        {%- assign my_feed = site.feeds | where_exp:"item", "item.myId == myId" | first %}
        if (!data) feed = '/{{ my_feed.category }}/{{ my_feed.slug }}.json?t=' + $.now();
        draw.getJSON();

    },


    test : function(id, size) {

        {{ content }}

    }


}
