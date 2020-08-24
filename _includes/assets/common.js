$(document).ready(function() {
    function initialize(name) {
        let link = $(".wy-menu-vertical").find(`[href="${decodeURI(name)}"]`);
        if (link.length > 0) {
            $(".wy-menu-vertical .current").removeClass("current");
            link.addClass("current");
            link.closest("li.toctree-l1").parent().addClass("current");
            link.closest("li.toctree-l1").addClass("current");
            link.closest("li.toctree-l2").addClass("current");
            link.closest("li.toctree-l3").addClass("current");
            link.closest("li.toctree-l4").addClass("current");
            link.closest("li.toctree-l5").addClass("current");
        }
    }

    function toggleCurrent(link) {
        let closest = link.closest("li");
        closest.siblings("li.current").removeClass("current");
        closest.siblings().find("li.current").removeClass("current");
        closest.find("> ul li.current").removeClass("current");
        closest.toggleClass("current");
    }

    function toc() {
        $(".wy-menu-vertical li.current").append('<ul class="content-toc"></ul>').html(function() {
            let level = parseInt(this.dataset.level);
            let temp = 0;
            let stack = [$(this).find(".content-toc")];

            $(".document").find("h2,h3,h4,h5,h6").each(function() {
                let anchor = $("<a/>").addClass("reference internal").text($(this).text()).attr("href", `#${this.id}`);
                let tagLevel = parseInt(this.tagName.slice(1)) - 1;

                if (tagLevel > temp) {
                    let parent = stack[0].children("li:last")[0];
                    if (parent) {
                        stack.unshift($("<ul/>").appendTo(parent));
                    }
                } else {
                    stack.splice(0, Math.min(temp - tagLevel, Math.max(stack.length - 1, 0)));
                }
                temp = tagLevel;

                $("<li/>").addClass(`toctree-l${level + tagLevel}`).append(anchor).appendTo(stack[0]);
            });
            if (!stack[0].html()) {
                stack[0].remove();
            }
        });
    }

    function set(name, value) {
        return localStorage.setItem(name, value);
    }

    function get(name) {
        return localStorage.getItem(name) || false;
    }

    function restore() {
        let scroll = get("scroll");
        let scrollTime = get("scrollTime");
        let scrollHost = get("scrollHost");

        if (scroll && scrollTime && scrollHost) {
            if (scrollHost == location.host && (Date.now() - scrollTime < 6e5)) {
                $(".wy-side-scroll").scrollTop(scroll);
            }
        }
        $(".wy-side-scroll").scroll(function() {
            set("scroll", this.scrollTop);
            set("scrollTime", Date.now());
            set("scrollHost", location.host);
        });
    }

    function highlight() {
        let text = new URL(location.href).searchParams.get("highlight");
        let box = ".highlighted-box";

        if (text) {
            $(".section").find("*").each(function() {
                try {
                    if (this.outerHTML.match(new RegExp(text, "im"))) {
                        $(this).addClass("highlighted-box");
                    }
                } catch (e) {
                    debug(e.message);
                }
            });
            $(".section").find(box).each(function() {
                if (($(this).find(box).length > 0)) {
                    $(this).removeClass(box);
                }
            });
        }
    }

    anchors.add();
    toc();
    initialize(location.pathname);
    restore();
    highlight();

    /* nested ul */
    $(".wy-menu-vertical ul").siblings("a").each(function() {
        let link = $(this);
        let expand = $('<span class="toctree-expand"></span>');

        expand.on("click", function(e) {
            e.stopPropagation();
            toggleCurrent(link);
            return false;
        });
        link.prepend(expand);
    });

    /* admonition */
    $(".admonition-title").each(function() {
        $(this).html(ui.admonition[$(this).attr("ui")]);
    });

    /* bind */
    $(document).on("click", '[data-toggle="wy-nav-top"]', function() {
        $('[data-toggle="wy-nav-shift"]').toggleClass("shift");
        $('[data-toggle="rst-versions"]').toggleClass("shift");
    });
    $(document).on("click", ".wy-menu-vertical .current ul li a", function() {
        $('[data-toggle="wy-nav-shift"]').removeClass("shift");
        $('[data-toggle="rst-versions"]').toggleClass("shift");
        toggleCurrent($(this));

        $("html,body").animate({
            scrollTop: $(this.hash).offset().top
        }, 500);
    });
    $(document).on("scroll", function() {
        let start = $(this).scrollTop() + ($(window).height() * 0.382);
        let items = [];

        $(".document").find("h1,h2,h3,h4,h5,h6").each(function() {
            items.push({
                offset: $(this).offset().top,
                id: this.id,
                level: parseInt(this.tagName.slice(1))
            });
        });
        for (let i = 0; i < items.length; i++) {
            if (start > items[i].offset) {
                if (i < items.length - 1) {
                    if (start < items[i + 1].offset) {
                        if (items[i].level == 1) {
                            initialize(location.pathname);
                        } else {
                            initialize("#" + items[i].id);
                        }
                    }
                } else {
                    initialize("#" + items[i].id);
                }
            }
        }
    });
    $(document).on("click", '[data-toggle="rst-current-version"]', function() {
        $('[data-toggle="rst-versions"]').toggleClass("shift-up");
    });
    $(window).bind("resize", function() {
        requestAnimationFrame(function() {});
    });
    $(window).bind("hashchange", () => initialize(location.hash || location.pathname));
});