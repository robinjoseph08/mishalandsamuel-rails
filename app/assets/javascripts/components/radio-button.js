App.RadioButtonComponent = Ember.Component.extend({

  actions: {

    assignValue: function (value) {
      this.set('guest.response', value);
    }

  }

});