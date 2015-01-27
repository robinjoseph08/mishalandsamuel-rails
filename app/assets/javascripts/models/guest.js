App.Guest = DS.Model.extend({

  name:   DS.attr('string'),
  coming: DS.attr('boolean'),
  party:  DS.belongsTo('party', { async: true }),
  meal:   DS.belongsTo('meal', { async: true })

});