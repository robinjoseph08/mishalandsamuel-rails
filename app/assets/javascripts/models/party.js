App.Party = DS.Model.extend({

  code:   DS.attr('string'),
  guests: DS.hasMany('guest', { async: true }),

});
