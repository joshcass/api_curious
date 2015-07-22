$( document ).ready(function() {
    setInterval(function(){
        var $tweetID = $('.tweet-list li:first-child').attr('id');
        $.ajax({ url: '/tweets/' + $tweetID +'/refresh/', success: function(data){
            $(data).hide().prependTo('.tweet-list').slideDown();
        }, dataType: "html"});
    }, 90000);
});
