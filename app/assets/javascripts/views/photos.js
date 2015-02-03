App.PhotosView = Ember.View.extend({

  didInsertElement: function () {
    // $('.owl-carousel').owlCarousel({
    //   singleItem: true,
    //   autoHeight: true
    // });
    // var settings = {
    //   viewport: [
    //     {
    //       width: 1200,
    //       columns: 5
    //     }, {
    //       width: 900,
    //       columns: 4
    //     }, {
    //       width: 500,
    //       columns: 3
    //     }, {
    //       width: 320,
    //       columns: 2
    //     }, {
    //       width: 0,
    //       columns: 2
    //     }
    //   ],
    //   historyapi: false
    // };

    // Gamma.init(settings);
    var selector = '.gallery';
    var $container = $(selector);
    // initialize
    var msnry = new Masonry(selector, {
      columnWidth: 200,
      itemSelector: '.item',
      isFitWidth: true,
      // isInitLayout: false
    });
    $container.imagesLoaded( function() {
      msnry.layout()
    });
  }

});