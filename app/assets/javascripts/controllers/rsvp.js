App.RsvpController = Ember.Controller.extend({

  code: "",
  isProcessing: false,

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
    }

  }

});