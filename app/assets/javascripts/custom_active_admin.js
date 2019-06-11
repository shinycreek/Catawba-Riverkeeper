$(document).on("ready", function() {
    if (location.pathname == "/admin/trash_loggers" || location.pathname == "/admin/pollution_reports") {
        if (location.search == "") {
            var statusInputActiveOption = $('#q_status_input').find('option[value=active]');
            if (statusInputActiveOption.length) {
                statusInputActiveOption.attr('selected', 'selected');
                $('.filter_form').submit();
            }
        }
    }
});
