DS.RESTAdapter.reopen({
  headers: {
    "X-CSRF-Token": $('meta[name="csrf-token"]').attr('content')
  }
});
