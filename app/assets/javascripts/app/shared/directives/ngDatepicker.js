(function () {
    'use strict';

    angular
        .module('reservation')
        .directive('ngDatepicker', DatepickerDirective);

    function DatepickerDirective() {
        return function (scope, element, attribute) {
            element.datepicker({
                autoclose: true,
                todayHighlight: true
            });
        }
    }
})();
