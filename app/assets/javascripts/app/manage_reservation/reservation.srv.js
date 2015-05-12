(function () {
    'use strict';

    angular
        .module('reservation.manage_reservation')
        .factory('Reservation', ReservationFactory);

    ReservationFactory.$inject = ['$resource'];

    function ReservationFactory($resource) {
        return $resource('/reservations/:id', {id: '@id'}, {
            query: {
              isArray: false
            },
            update: {
                method: 'PUT'
            }
        });
    }
})();