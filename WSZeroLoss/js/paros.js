$(function () {
    initEventos();
});


function initEventos() {
    $("#fechaIni").datetimepicker({
        onShow: function (ct) {
            this.setOptions({
                maxDate: jQuery('#fechaIni').val() ? jQuery('#fechaFin').val() : false
            })
        }
    });

    $("#fechaFin").datetimepicker({
        onShow: function (ct) {
            this.setOptions({
                minDate: jQuery('#fechaIni').val() ? jQuery('#fechaFin').val() : false
            })
        },
    });

    $.datetimepicker.setLocale('es');

}