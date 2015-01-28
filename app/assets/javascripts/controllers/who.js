App.WhoController = Ember.Controller.extend({

  showBridesmaids: true,

  actions: {

    enableProperty: function (prop) {
      this.set(prop, true);
    },

    disableProperty: function (prop) {
      this.set(prop, false);
    }

  }

});