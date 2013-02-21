//= require jquery-ui

(function($) {
  $(document).ready(function() {
    $('.handle').closest('tbody').activeAdminSortable();
  });

  $.fn.activeAdminSortable = function() {
    this.sortable({
      update: function(event, ui) {
        var url = ui.item.find('[data-sort-url]').data('sort-url');
	  
        $.ajax({
          url: url,
          type: 'post',
          data: { position: ui.item.index() },
          success: function() { 
	      console.log("do changes");
	  }
        });
      }
    });

    this.disableSelection();
  }
})(jQuery);
