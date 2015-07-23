$(document).ready(function() {
    function addTweets() {
        var $tweetID = $('.tweet-list li:last-child').attr('id');
        var $spinner = $('div#spinner');
        $tweetID = (parseInt($tweetID, 10) - 100).toString();
        $spinner.removeClass('invisible');

        $.ajax({ url: '/tweets/' + $tweetID + '/load_more', success: function(data){
            $(data).hide().appendTo('.tweet-list').slideDown();
        }, dataType: 'html'});
        $spinner.addClass('invisible');
    };

    $(window).scroll(function() {
        var $winTop = $(window).scrollTop(), $docHeight = $(document).height(), $winHeight = $(window).height();

        if ($winTop == $docHeight - $winHeight) {
            addTweets();
        }
    });
});
