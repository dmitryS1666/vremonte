//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

var ready = function () {
    App.cable.subscriptions.create('RequestsChannel', {
        connected: function () {
            this.perform('follow');
        },

        received: function (data) {
            var $request_list = $('.requests-list');
            if(/destroy=true/.test(data)){
                console.log(data);
            } else {
                console.log(data);
                $request_list.append(data);
            }
        }
    })
};

var validation = function () {
    if($('#new_request').length) {
        var input_title = document.getElementById('request_title');
        var input_body = $('#request_body');

        $('#request_title').bind('input', function() {
            if(input_title.value.length < 5) {
                input_title.className += " invalid";
            } else {
                input_title.className -= " invalid";
            }
        });

        $('#input_body').bind('input', function() {
            if(input_body.value.length < 10) {
                input_body.className += " invalid";
            } else {
                input_body.className -= " invalid";
            }
        });
    }
};

$(document).on('turbolinks:load', ready);
$(document).on('turbolinks:load', validation);