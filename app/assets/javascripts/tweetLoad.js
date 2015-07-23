$(document).ready(function() {
    function addTweets() {
        var $tweetID = $('.tweet-list li:last-child').attr('id');
        var $loader = $('div#loader');
        $tweetID = (parseInt($tweetID, 10) - 100).toString();

        $loader.html('<img src="/assets/load_spinner.gif"/>');

        $.ajax({ url: '/tweets/' + $tweetID + '/load_more', success: function(data){
            $(data).hide().appendTo('.tweet-list').slideDown();
        }, dataType: 'html'});
        $loader.empty();
    };

    $(window).scroll(function() {
        var $winTop = $(window).scrollTop(), $docHeight = $(document).height(), $winHeight = $(window).height();

        if ($winTop == $docHeight - $winHeight) {
            addTweets();
        }
    });
});
