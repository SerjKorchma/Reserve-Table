(function () {
    'use strict';

    angular
        .module('reservation.manage_reservation')
        .controller('CreateReservationCtrl', CreateReservationCtrl);

    CreateReservationCtrl.$inject = ['Reservation', '$modalInstance', 'table'];

    function CreateReservationCtrl(Reservation, $modalInstance, table) {
        var vm = this;
        vm.reservation = {
            table_number: table,
            start_date: new Date(),
            end_date: new Date()
        };
        vm.save = save;
        vm.close = close;

        function save(form) {
            if (form.$valid) {
                vm.errors = [];

                var date = moment(vm.reservation.date).format('YYYY-MMM-DD'),
                    reservation = new Reservation();
                reservation.table_number = table;
                reservation.start_time = date + ' ' + moment(vm.reservation.start_time).format('HH:mm');
                reservation.end_time = date + ' ' + moment(vm.reservation.end_time).format('HH:mm');

                reservation.$save(function (data) {
                    if (data.reservation) {
                        $modalInstance.close(data.reservation);
                    } else {
                        vm.errors = data.reservations;
                    }
                });
            }
        }

        function close() {
            $modalInstance.dismiss('cancel');
        }
    }
})();