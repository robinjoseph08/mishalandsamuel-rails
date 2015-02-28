App.PhotosRoute = Ember.Route.extend({

  model: function () {
    return this.store.find('photo');
  }

});