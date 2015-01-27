App.BannerContainerComponent = Ember.Component.extend({

  hasBanners: function () {
    return this.get('errors').length > 0 || this.get('notices').length > 0
  }.property('errors.@each', 'notices.@each'),

  actions: {

    removeError: function (error) {
      this.get('errors').removeObject(error);
    },

    removeNotice: function (notice) {
      this.get('notices').removeObject(notice);
    }

  }

});
