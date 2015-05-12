(function () {
    'use strict';

    angular
        .module('reservation')
        .directive('ngTimepicker', ngTimepickerDirective);

    function ngTimepickerDirective() {
        return function (scope, element, attribute) {
            element.timepicker({
                showInputs: false,
                disableFocus: true
            });
        }
    }
})();
