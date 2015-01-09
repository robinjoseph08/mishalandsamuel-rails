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
  // this.resource('posts');
});
