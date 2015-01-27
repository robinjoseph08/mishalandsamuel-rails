App.Guest = DS.Model.extend({

  name:      DS.attr('string'),
  attending: DS.attr('boolean'),
  party:     DS.belongsTo('party', { async: true }),
  meal:      DS.belongsTo('meal', { async: true }),

  notAttending: function () {
    return !this.get('attending');
  }.property('attending'),

  clearMeal: function () {
    if (!this.get('attending')) {
      this.set('meal', null);
    }
  }.observes('attending')

});