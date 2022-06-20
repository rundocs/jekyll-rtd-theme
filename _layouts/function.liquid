jQuery(function($)
{
    // jQuery document.ready will be executed just after html dom tree has been parsed out.
    // So it is far more earlier executed than window onload.
    $(document).ready(function()
    {
        // to stick navbar on top and hash
        top_menu_height = $('.templatemo-top-menu').height();
        $('html,body').scrollspy({target: '#templatemo-nav-bar', offset: top_menu_height + 10});

        // do scroll and clear the hash anytime someone arrives with a hash tag
        // https://stackoverflow.com/a/50688363/4058484
        if( typeof(location.hash) !== 'undefined' && location.hash.length ) 
        {
            var location_hash = location.hash.split('?')[0];
            history.replaceState(null, null, location.pathname);
            scrollTo(location_hash);
        }

        // set links which point outside
        $('.external-link').unbind('click');
        $(document.links).filter(function() {
            return this.hostname != window.location.hostname;
        }).attr('target', '_blank'); 

        // scroll to top
        $('#btn-back-to-top').click(function(e)
        {
            e.preventDefault();
            scrollTo('#templatemo-top');
        });

        // scroll to specific id when click on link
        $('.internal-link, .carousel-inner a').click(function(e)
        {
            e.preventDefault(); 
            var linkId = $(this).attr('href');
            scrollTo(linkId);
            return false;
        });

        // scroll to specific id when click on menu
        $('.templatemo-top-menu .navbar-nav a').click(function(e)
        {
            e.preventDefault(); 
            var linkId = $(this).attr('href');
            scrollTo(linkId);
            if($('.navbar-toggle').is(":visible") == true)
            {
                $('.navbar-collapse').collapse('toggle');
            }
            $(this).blur();
            return false;
        });

        // scrollspy to auto active the nav item
        $('.templatemo-top-menu').stickUp(); 

        // This API has been removed in jQuery 3.0; please use .on( "load", handler ) 
        // instead of .load( handler ) and .trigger( "load" ) instead of .load().
        // https://api.jquery.com/load-event/

        // load page in sequence with Jquery via  div loaded
        // https://stackoverflow.com/q/15674733/4058484
        /*$('#one').load("one.php", function() {  // first div loaded
            $('#two').load("two.php", function() { // second div loaded
                $('#three').load("three.php", function() { // third div loaded  });
            });
        });*/

        // gallery category
        $('.templatemo-gallery-category a').click(function(e)
        {
            e.preventDefault(); 
            $(this).parent().children('a').removeClass('active');
            $(this).addClass('active');
            var linkClass = $(this).attr('href');
            $('.gallery').each(function(){
                if($(this).is(":visible") == true){
                   $(this).hide();
                };
            });
            $(linkClass).fadeIn();  
        });

        //chetabahana-gallery
        $('a.colorbox').colorbox({
            rel: function(){
                return $(this).data('group');
            }
        });

        //chetabahana-skema
        $('.download').click(function(ev) {draw.xmlData();});
        $('.theme').change(function() {draw.change();});

        //chetabahana-portfolio
        $(".templatemo-project-gallery").simplyScroll();

        // automatically generate unique DOM ids using jQuery-ui
        // https://stackoverflow.com/a/20061124/4058484
        window.uniqueId = function(){
            return 'myid-' + myIdcounter++;
        }

    });

    // Window.onload event will be executed only when all page resources
    // ( images, audio, video etc ) has been downloaded in the page.
    $(window).on('load', function()
    {
        // unbind external link
        $('.external-link').unbind('click');

        // assign unique id
        // https://api.jqueryui.com/uniqueId/
        $('.theme').each(function (i, e) {
            var id = uniqueId();
            var name = uniqueId();
            $(e).attr('name', name).attr('id', id);
        });

        // draw diagram
        $.getScript('/diagram.js?t=' + $.now(), function() {
            $('.theme').val('hand');
            draw.getJSON();

        });

    });

    //catch Scrollspy event
    $(window).on('activate.bs.scrollspy', function (event) {
        //if ($('#diagram svg').width() < $('#diagram').width()) draw.change();
    })

});

// init scrollTo 
function scrollTo(selectors)
{
    if(!$(selectors).length) return;
    var selector_top = $(selectors).offset().top - top_menu_height;
    $('html,body').animate({scrollTop: selector_top }, 'slow');
}

// filtering json object
function filterBy(data, filters = {}) {
    // Set up the specific defaults that will show everything:
    const defaults = {
        category: null,
        yearFrom: 1895,
        yearTo: 2100,
        gender: null
    }

    // Merge any filters with the defaults
    filters = Object.assign({}, defaults, filters);

    // Filter based on that filters object:
    return data.filter(laur => {
        return (laur.yearFrom >= filters.yearFrom) &&
           (laur.yearTo <= filters.yearTo);
  });
}

// set params 
var myIdcounter = 0;
var top_menu_height = 0;

// set editor
var editor = ace.edit("editor");
editor.setOptions({fontSize: "10pt"});
editor.setTheme("ace/theme/crimson_editor");
editor.getSession().setMode("ace/mode/asciidoc");
editor.getSession().on('change', _.debounce(function() {draw.diagram();}, 100));

// get params 
var params, regex = /[?&]([^=#]+)=([^&#]*)/g, url = window.location.href, params = {}, match;
while(match = regex.exec(url)) {params[match[1]] = match[2];}
