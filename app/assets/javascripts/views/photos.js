App.PhotosView = Ember.View.extend({

  didInsertElement: function () {
    $('.owl-carousel').owlCarousel({
      singleItem: true,
      autoHeight: true
    });
  }

});