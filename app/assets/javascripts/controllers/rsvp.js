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
      this.get('notices').pushObjects(["Saved!"]);
    }
  },

  failure: function (resp) {
    if (resp.responseJSON && resp.responseJSON.errors) {
      this.get('errors').pushObjects(resp.responseJSON.errors);
    } else {
      this.get('errors').pushObjects(['Looks like something expected happened. Try refreshing the page.']);
    }
  },

  actions: {

    findParty: function () {
      var code = this.get('code');

      if (code.length > 0) {
        this.set('isProcessing', true);
        this.store.find('party', { code: code }).then(function (parties) {
          var party = parties.get('firstObject');
          this.set('isProcessing', false);
          if (party) {
            this.set('invalidCode', false);
            this.set('model', party);
          } else {
            this.set('invalidCode', true);
            this.set('model', null);
          }
        }.bind(this), function (resp) {
          if (resp.status === 404) {
            this.set('invalidCode', true);
            this.set('model', null);
          }
          this.set('isProcessing', false);
        }.bind(this));
      } else {
        this.set('invalidCode', false);
        this.set('model', null);
      }
    },

    allAttending: function () {
      this.get('model.guests').then(function (guests) {
        guests.forEach(function (guest) {
          guest.set('attending', true);
        });
      });
    },

    allNotAttending: function () {
      this.get('model.guests').then(function (guests) {
        guests.forEach(function (guest) {
          guest.set('attending', false);
        });
      });
    },

    submit: function () {
      // save party
      var party = this.get('model');
      party.save().then(this.successParty.bind(this), this.failure.bind(this));
    }

  }

});