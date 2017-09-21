(function ($) {
  $(document).ready(function () {
    $('h1,h2,h3,h4,h5,h6').filter('[id]').each(function () {
      $(this).append(
        '<a class="anchor" title="Link to the section" href="#' + 
        $(this).attr('id') +
        '">&nbsp;&para;</a>'
      );
    });
  });
})(jQuery);
