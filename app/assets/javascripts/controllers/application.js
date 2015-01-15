App.ApplicationController = Ember.Controller.extend({

  muteAudio: false,

  actions: {

    toggleProperty: function (prop) {
      this.toggleProperty(prop);
    }

  }

});