(function () {
    function focusPrev(pool) {
        var a = document.activeElement;
        if (!a || pool.index(a) == -1) {
            pool.first().focus();
            return;
        }
        var currIdx = pool.index(a);
        if (currIdx > 0) pool.eq(currIdx - 1).focus();
        else pool.last().focus();
    };
    function focusNext(pool) {
        var a = document.activeElement;
        if (!a || pool.index(a) == -1) {
            pool.first().focus();
            return;
        }
        var currIdx = pool.index(a);
        if (currIdx < pool.length - 1) pool.eq(currIdx + 1).focus();
        else {
        	//pool.first().focus();
        	$("#addbut").trigger('click');
        	pool.last().focus();
        }
    };
    var INPUT_SELECTOR = "input,select,textarea,button", IGNORE_CSS = "e2t-ignore";
    jQuery.fn.getFocusCandidates = function (tabRange) {
        return this.find(INPUT_SELECTOR).filter("[tabindex]:not([tabindex=-1])")
			//ignore disabled, readonly or invisible inputs
			.filter(
                ":not([disabled]):not([readonly]):visible" +
                //for enter key, e2t-ignore fields are excluded
                //for tab key, they are included
                (tabRange ? "" : ":not(." + IGNORE_CSS + ")")
            )
			//order by tabindex
			.sort(function (a, b) { return a.tabIndex > b.tabIndex ? 1 : -1; });
    };
    var CONTAINER_CSS = "e2t-container", ACTIVE_CSS = "e2t-active";
    jQuery.fn.enableEnterToTab = function (options) {
        var settings = $.extend({
            //let ya-enter2tab control tab key behavior, prevent focus going outside of the container
            captureTabKey: false 
        }, options);
        return this.each(function () {
            var $container = $(this);
            $container.addClass(CONTAINER_CSS)
            .on("keydown", "[tabindex]:not(textarea)", function (e) {
                var isTab = e.which == 9;
				var isRevTab = isTab && e.shiftKey;
                var isEnter = e.which == 13;
                var $fld = $(this);
                var isIgnore = $fld.is(".e2t-ignore"), isKeyOff = $fld.is(".e2t-keyoff");
                if (isEnter && (isIgnore || isKeyOff))
                    return;
                if (isEnter || (settings.captureTabKey && isTab)) {
                    e.preventDefault();
					if (isRevTab)
						focusPrev($container.getFocusCandidates(isTab));
					else 
						focusNext($container.getFocusCandidates(isTab));
                }
            });
        });
    };

})(jQuery);