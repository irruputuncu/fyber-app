$('document').ready(function() {
  $('#results').on('click', '.pagination-link', function(event) {
    event.preventDefault();
    $('#page').val($(this).data('page'));
    $('#offer-form form').submit();
  });
});
