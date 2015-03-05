App.WhoRoute = Ember.Route.extend({

  setupController: function (controller, model) {
    this._super(controller, model);
    mixpanel.track("Visit 'Who' page");
  }

});