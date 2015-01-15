App.Router.reopen({
  location: 'history'
});

Ember.Route.reopen({
  activate: function (router) {
    this._super(router);

    var text = "Mishal and Samuel";
    var title = this.get('title');

    if(title) {
      text += " | " + title;
    }

    $(document).find('title').text(text);
  }
});

App.Router.map(function() {

  this.resource('story');
  this.resource('photos');
  this.resource('party');
  this.resource('registry');
  this.resource('where');
  this.resource('rsvp');

});
