App.Party = DS.Model.extend({

  code:   DS.attr('string'),
  email:  DS.attr('string'),
  coming: DS.attr('boolean'),
  guests: DS.hasMany('guest', { async: true }),

});