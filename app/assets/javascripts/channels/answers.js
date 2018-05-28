var ready = function () {
  App.cable.subscriptions.create('AnswersChannel', {
    connected: function () {
      this.perform('follow');
    },

    received: function (data) {
        var $answer_list = $('.answers-list');
        $answer_list.append(data);
        document.getElementById('answer-button').disabled = true;
        document.getElementById('new_answer').style.visibility = 'hidden';
    }
  })
};

$(document).on('turbolinks:load', ready);