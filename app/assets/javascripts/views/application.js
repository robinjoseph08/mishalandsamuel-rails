App.ApplicationView = Ember.View.extend({

  didInsertElement: function () {
    var $el = $('audio');
    if ($el.length > 0) {
      $el[0].volume = 0.5;
    }
  }

});