(function () {
    'use strict';

    angular
        .module('reservation.manage_reservation')
        .controller('ReservationListCtrl', ReservationListCtrl);

    ReservationListCtrl.$inject = ['Reservation', '$modal'];

    function ReservationListCtrl(Reservation, $modal) {
        var vm = this;
        vm.tables = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
        vm.getItemClass = getItemClass;
        vm.openCreateModal = openCreateModal;
        vm.checkReserved = checkReserved;
        vm.getTableReservations = getTableReservations;

        //get all reservations
        Reservation.query().$promise.then(function (data) {
            vm.reservations = data.reservations;

        });

        function checkReserved(table) {
            return _.findWhere(vm.reservations, {table_number: table});
        }

        function getTableReservations(table) {
            return _.where(vm.reservations, {table_number: table});
        }

        function getItemClass(table) {
            return {
                blue: table % 5 == 1,
                green: table % 5 == 2,
                'light-red': table % 5 == 3,
                color: table % 5 == 4,
                'light-orange': table % 5 == 0

            }
        }

        function openCreateModal(table) {
            var modalInstance = $modal.open({
                animation: true,
                templateUrl: 'CreateReservation.html',
                controller: 'CreateReservationCtrl as vm',
                size: 'lg',
                resolve: {
                    table: function () {
                        return table;
                    }
                }
            });

            modalInstance.result.then(function (reservation) {
                vm.reservations.push(reservation);
            });
        }
    }

})();