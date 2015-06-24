App.RadioButtonComponent = Ember.Component.extend({

  actions: {

    assignValue: function (value) {
      if (!this.get('disabled')) {
        this.set('guest.response', value);
      }
    }

  }

});
