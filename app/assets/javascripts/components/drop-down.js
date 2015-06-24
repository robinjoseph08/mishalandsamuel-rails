App.DropDownComponent = Ember.Component.extend({

  isOpen: false,

  caretClass: function () {
    return this.get('isOpen') ? 'fa-caret-up' : 'fa-caret-down';
  }.property('isOpen'),

  actions: {

    toggleProperty: function (prop) {
      if (!this.get('disabled')) {
        this.toggleProperty(prop);
      }
    },

    selectItem: function (item) {
      this.set('item', item);
      this.toggleProperty("isOpen");
    }

  }

});
