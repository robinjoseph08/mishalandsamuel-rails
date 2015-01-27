DS.RESTAdapter.reopen({

  namespace: 'api',

  headers: {
    "X-CSRF-Token": $('meta[name="csrf-token"]').attr('content')
  }

});
