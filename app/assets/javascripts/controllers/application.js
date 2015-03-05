App.ApplicationController = Ember.Controller.extend({

  init: function () {
    var code = localStorage.getItem('code') || '';
    if (code != '') {
      mixpanel.people.set({
        'Code': code.toUpperCase()
      });
      mixpanel.identify(code.toUpperCase());
    }
  },

  muteAudio: false,
  updateMuteAudio: function () {
    var state = this.get('muteAudio') ? 'muted' : 'unmuted';
    mixpanel.track('Audio ' + state);
  }.observes('muteAudio'),

  actions: {

    toggleProperty: function (prop) {
      this.toggleProperty(prop);
    },

    clickedLink: function (link, referrer) {
      mixpanel.track('Click external link', {
        "Link":      link,
        "Referrer" : referrer
      })
    }

  }

});