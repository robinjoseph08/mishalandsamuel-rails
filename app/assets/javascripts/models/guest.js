App.Guest = DS.Model.extend({

  name:     DS.attr('string'),
  response: DS.attr('string'),
  party:    DS.belongsTo('party', { async: true }),
  meal:     DS.belongsTo('meal', { async: true }),

  isAttending: function () {
    return this.get('response') === 'attending';
  }.property('response'),

  isNotAttending: function () {
    return this.get('response') === 'not_attending';
  }.property('response'),

  clearMeal: function () {
    if (this.get('response') !== 'attending') {
      this.set('meal', null);
    }
  }.observes('response')

});