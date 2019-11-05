var common = {
    init function () {
        common.registerEvent();
    },
    registerEvent: function () {
        $("#txtKeyword").autocomplete({
            minLength: 0,
            source: function (request, response) {
                $.ajax({
                    url: "/Product/ListName",
                    dataType: "jsonp",
                    data: {
                        term: request.term
                    },
                    success: function (data) {
                        response(data);
                    }
                });
            },
            focus: function (event, ui) {
                $("#Keyword").val(ui.item.label);
                return false;
            },
            select: function (event, ui) {
                $("#Keyword").val(ui.item.label);
              

                return false;
            }
        })
            .autocomplete("instance")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<div>" + item.label + "<br>" + item.desc + "</div>")
                    .appendTo(ul);
            };
    }
}
common.init();