App.WhoController = Ember.Controller.extend({

  showBridesmaids: true,
  updateShowBridesmaids: function () {
    var state = this.get('showBridesmaids') ? 'Bridesmaids' : 'Groomsmen';
    mixpanel.track('Show ' + state);
  }.observes('showBridesmaids'),

  actions: {

    enableProperty: function (prop) {
      this.set(prop, true);
    },

    disableProperty: function (prop) {
      this.set(prop, false);
    }

  }

});