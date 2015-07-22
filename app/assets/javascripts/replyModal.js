$( document ).ready(function() {
    $('#replyModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var recipient = button.data('name');
        var tweetID = button.data('id');

        var modal = $(this);
        modal.find('.modal-title').text('Reply to @' + recipient);
        modal.find('.modal-body textarea').val('@' + recipient);
        modal.find('.tweet-id').attr('value', tweetID);
    });
});
