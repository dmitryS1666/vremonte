//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

var ready = function () {
  App.cable.subscriptions.create('CommentsChannel', {
    connected: function () {
      this.perform('follow');
    },

    received: function (data) {
        var $comment_list = $('.comments-list');
        if(/destroy=true/.test(data)){
            console.log(data);
        } else {
            console.log(data);
            $comment_list.append(data);
        }
    }
  })
};

$(document).on('turbolinks:load', ready);