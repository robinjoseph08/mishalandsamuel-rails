App.PhotosView = Ember.View.extend({

  didInsertElement: function () {
    var selector = '.gallery';
    var $container = $(selector);
    var msnry = new Masonry(selector, {
      columnWidth: 200,
      itemSelector: '.item',
      isFitWidth: true
    });
    $container.imagesLoaded( function() {
      msnry.layout()
    });
  }

});