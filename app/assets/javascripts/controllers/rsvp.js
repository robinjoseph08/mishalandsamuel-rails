App.RsvpController = Ember.Controller.extend({

  code: localStorage.getItem('code') || '',
  codeChanged: function () {
    localStorage.setItem('code', this.get('code'));
  }.observes('code'),

  invalidCode:  false,
  isProcessing: false,
  errors:       [],
  notices:      [],
  successCount: 0,

  meals: function () {
    return Ember.ArrayProxy.createWithMixins(Ember.SortableMixin, {
      sortProperties: ['id'],
      content: this.get('unsortedMeals')
    });
  }.property('unsortedMeals'),

  unsortedMeals: function () {
    return this.store.find('meal');
  }.property(),

  guests: function () {
    return Ember.ArrayProxy.createWithMixins(Ember.SortableMixin, {
      sortProperties: ['id'],
      content: this.get('content.guests')
    });
  }.property('content.guests'),

  successParty: function (resp) {
    // save guests
    this.set('successCount', 0);
    this.get('model.guests').then(function (guests) {
      guests.forEach(function (guest) {
        guest.save().then(this.successGuest.bind(this), this.failure.bind(this));
      }.bind(this));
    }.bind(this));
  },

  successGuest: function (resp) {
    this.incrementProperty('successCount');
    if (this.get('successCount') == this.get('model.guests.length')) {
      this.get('errors').setObjects([]);
      this.get('notices').pushObjects(["Saved! Thank you for your RSVP!"]);
      mixpanel.track('Successfully updated RSVP');
    }
  },

  failure: function (resp) {
    var errors = ['Looks like something expected happened. Try refreshing the page.'];
    if (resp.responseJSON && resp.responseJSON.errors) {
      errors = resp.responseJSON.errors;
    }
    mixpanel.track('RSVP error', {
      errors: errors
    });
    this.get('errors').pushObjects(errors);
  },

  actions: {

    findParty: function () {
      var code = this.get('code');

      if (code.length > 0) {
        this.set('isProcessing', true);
        this.store.find('party', { code: code }).then(function (parties) {
          // sucessful request
          var party = parties.get('firstObject');
          this.set('isProcessing', false);
          if (party) {
            // successfully got a party
            this.set('invalidCode', false);
            this.set('model', party);
            mixpanel.people.set({
              'Code':     code.toUpperCase(),
              'Party ID': party.get('id')
            });
            mixpanel.identify(code.toUpperCase());
          } else {
            // failure to get a party
            this.set('invalidCode', true);
            this.set('model', null);
            mixpanel.track('Empty code request', {
              code: code.toUpperCase()
            });
          }
        }.bind(this), function (resp) {
          // failed request
          if (resp.status === 404) {
            this.set('invalidCode', true);
            this.set('model', null);
          }
          this.set('isProcessing', false);
          mixpanel.track('Failed code request', {
            code:   code.toUpperCase(),
            status: resp.status
          });
        }.bind(this));
      } else {
        this.set('invalidCode', false);
        this.set('model', null);
      }
    },

    setAll: function (value) {
      this.get('model.guests').then(function (guests) {
        guests.forEach(function (guest) {
          guest.set('response', value);
        });
      });
      var state = value === 'attending' ? 'All Are Attending' : 'All Are Not Attending';
      mixpanel.track("Set '" + state + "'");
    },

    submit: function () {
      // save party
      var party = this.get('model');
      party.save().then(this.successParty.bind(this), this.failure.bind(this));
    }

  }

});