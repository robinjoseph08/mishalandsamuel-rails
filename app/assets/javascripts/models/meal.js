App.Meal = DS.Model.extend({

  name: DS.attr('string'),

  isKidsMeal: function () {
    return this.get('name') === "Kid's Meal";
  }.property('name')

});