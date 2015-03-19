App.IndexController = Ember.Controller.extend({

  needs: ['application'],

  currentTimeMetronome: function() {
    var interval = 1000;
    Ember.run.later(this, function() {
      this.notifyPropertyChange('currentTimePulse');
      this.currentTimeMetronome();
    }, interval);
  }.on('init'),

  currentTime: function() {
    var date = new Date(2015, 5, 27, 10, 0);
    var units = countdown.DAYS | countdown.HOURS | countdown.MINUTES | countdown.SECONDS;
    return countdown(date, null, units).toString().replace(/(,|and )/g, '').replace(/([A-Za-z]+)/g, '<span class="words">$1</span>');
  }.property('currentTimePulse')

});
