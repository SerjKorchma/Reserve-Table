//= require jquery
//= require bootstrap-sprockets
//= require angular
//= require angular-resource
//= require angular-ui-bootstrap
//= require angular-ui-bootstrap-tpls
//= require bootstrap-timepicker
//= require bootstrap-datepicker
//= require underscore
//= require moment
//= require_self
//= require app/manage_reservation/manage_reservation.mdl
//= require_tree ./app


(function () {
    'use strict';

    angular
        .module('reservation', [
            'ngResource',
            'ui.bootstrap',
            'reservation.manage_reservation'
        ])
    ;

})();