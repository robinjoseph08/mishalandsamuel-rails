App.WhereRoute = Ember.Route.extend({

  setupController: function (controller, model) {
    this._super(controller, model);
    mixpanel.track("Visit 'Where' page");
  }

});