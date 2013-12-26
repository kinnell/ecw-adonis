function noty(e) {
    return jQuery.noty(e)
}(function (e) {
    e.noty = function (t, n) {
        var r = {}, i = null,
            s = !1;
        r.init = function (t) {
            r.options = e.extend({}, e.noty.defaultOptions, t);
            r.options.type = r.options.cssPrefix + r.options.type;
            r.options.id = r.options.type + "_" + (new Date).getTime();
            r.options.layout = r.options.cssPrefix + "layout_" + r.options.layout;
            r.options.custom.container && (n = r.options.custom.container);
            s = e.type(n) === "object" ? !0 : !1;
            return r.addQueue()
        };
        r.addQueue = function () {
            var t = e.inArray(r.options.layout, e.noty.growls) == -1 ? !1 : !0;
            t || (r.options.force ? e.noty.queue.unshift({
                options: r.options
            }) : e.noty.queue.push({
                options: r.options
            }));
            return r.render(t)
        };
        r.render = function (t) {
            var o = s ? n.addClass(r.options.theme + " " + r.options.layout + " noty_custom_container") : e("body");
            if (t) {
                e("ul.noty_cont." + r.options.layout).length == 0 && o.prepend(e("<ul/>").addClass("noty_cont " + r.options.layout));
                o = e("ul.noty_cont." + r.options.layout)
            } else {
                if (!e.noty.available) return r.options.id;
                var u = e.noty.queue.shift();
                if (e.type(u) !== "object") {
                    e.noty.available = !0;
                    return r.options.id
                }
                e.noty.available = !1;
                r.options = u.options
            }
            r.container = o;
            r.bar = e('<div class="noty_bar"/>').attr("id", r.options.id).addClass(r.options.theme + " " + r.options.layout + " " + r.options.type);
            i = r.bar;
            i.append(r.options.template).find(".noty_text").html(r.options.text);
            i.data("noty_options", r.options);
            r.options.closeButton ? i.addClass("noty_closable").find(".noty_close").show() : i.find(".noty_close").remove();
            i.find(".noty_close").bind("click", function () {
                i.trigger("noty.close")
            });
            r.options.buttons && (r.options.closeOnSelfClick = r.options.closeOnSelfOver = !1);
            r.options.closeOnSelfClick && i.bind("click", function () {
                i.trigger("noty.close")
            }).css("cursor", "pointer");
            r.options.closeOnSelfOver && i.bind("mouseover", function () {
                i.trigger("noty.close")
            }).css("cursor", "pointer");
            if (r.options.buttons) {
                $buttons = e("<div/>").addClass("noty_buttons");
                i.find(".noty_message").append($buttons);
                e.each(r.options.buttons, function (t, n) {
                    bclass = n.type ? n.type : "gray";
                    $button = e("<button/>").addClass(bclass).html(n.text).appendTo(i.find(".noty_buttons")).bind("click", function () {
                        e.isFunction(n.click) && n.click.call($button, i)
                    })
                })
            }
            return r.show(t)
        };
        r.show = function (t) {
            r.options.modal && e("<div/>").addClass("noty_modal").addClass(r.options.theme).prependTo(e("body")).fadeIn("fast");
            i.close = function () {
                return this.trigger("noty.close")
            };
            t ? r.container.prepend(e("<li/>").append(i)) : r.container.prepend(i);
            (r.options.layout == "noty_layout_topCenter" || r.options.layout == "noty_layout_center") && e.noty.reCenter(i);
            i.bind("noty.setText", function (t, n) {
                i.find(".noty_text").html(n);
                (r.options.layout == "noty_layout_topCenter" || r.options.layout == "noty_layout_center") && e.noty.reCenter(i)
            });
            i.bind("noty.setType", function (t, n) {
                i.removeClass(i.data("noty_options").type);
                n = i.data("noty_options").cssPrefix + n;
                i.data("noty_options").type = n;
                i.addClass(n);
                (r.options.layout == "noty_layout_topCenter" || r.options.layout == "noty_layout_center") && e.noty.reCenter(i)
            });
            i.bind("noty.getId", function (e) {
                return i.data("noty_options").id
            });
            i.one("noty.close", function (t) {
                var n = i.data("noty_options");
                n.onClose && n.onClose();
                n.modal && e(".noty_modal").fadeOut("fast", function () {
                    e(this).remove()
                });
                i.clearQueue().stop().animate(i.data("noty_options").animateClose, i.data("noty_options").speed, i.data("noty_options").easing, i.data("noty_options").onClosed).promise().done(function () {
                    if (e.inArray(i.data("noty_options").layout, e.noty.growls) > -1) i.parent().remove();
                    else {
                        i.remove();
                        e.noty.available = !0;
                        r.render(!1)
                    }
                })
            });
            r.options.onShow && r.options.onShow();
            i.animate(r.options.animateOpen, r.options.speed, r.options.easing, r.options.onShown);
            r.options.timeout && i.delay(r.options.timeout).promise().done(function () {
                i.trigger("noty.close")
            });
            return r.options.id
        };
        return r.init(t)
    };
    e.noty.get = function (t) {
        return e("#" + t)
    };
    e.noty.close = function (t) {
        for (var n = 0; n < e.noty.queue.length;) e.noty.queue[n].options.id == t ? e.noty.queue.splice(t, 1) : n++;
        e.noty.get(t).trigger("noty.close")
    };
    e.noty.setText = function (t, n) {
        e.noty.get(t).trigger("noty.setText", n)
    };
    e.noty.setType = function (t, n) {
        e.noty.get(t).trigger("noty.setType", n)
    };
    e.noty.closeAll = function () {
        e.noty.clearQueue();
        e(".noty_bar").trigger("noty.close")
    };
    e.noty.reCenter = function (t) {
        t.css({
            left: (e(window).width() - t.outerWidth()) / 2 + "px"
        })
    };
    e.noty.clearQueue = function () {
        e.noty.queue = []
    };
    var t = window.alert;
    e.noty.consumeAlert = function (t) {
        window.alert = function (n) {
            t ? t.text = n : t = {
                text: n
            };
            e.noty(t)
        }
    };
    e.noty.stopConsumeAlert = function () {
        window.alert = t
    };
    e.noty.queue = [];
    e.noty.growls = ["noty_layout_topLeft", "noty_layout_topRight", "noty_layout_bottomLeft", "noty_layout_bottomRight"];
    e.noty.available = !0;
    e.noty.defaultOptions = {
        layout: "top",
        theme: "noty_theme_default",
        animateOpen: {
            height: "toggle"
        },
        animateClose: {
            height: "toggle"
        },
        easing: "swing",
        text: "",
        type: "alert",
        speed: 500,
        timeout: 5e3,
        closeButton: !1,
        closeOnSelfClick: !0,
        closeOnSelfOver: !1,
        force: !1,
        onShow: !1,
        onShown: !1,
        onClose: !1,
        onClosed: !1,
        buttons: !1,
        modal: !1,
        template: '<div class="noty_message"><span class="noty_text"></span><div class="noty_close"></div></div>',
        cssPrefix: "noty_",
        custom: {
            container: null
        }
    };
    e.fn.noty = function (t) {
        return this.each(function () {
            new e.noty(t, e(this))
        })
    }
})(jQuery);