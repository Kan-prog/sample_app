// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
            // http://bloggerever.com

$(function () {
    $.FindContainer = function () {
        $('.tab-contents>div').each(function findcontent() {
            var newindex = $('.activetab').index();
            var newheight = $('.activetab').height();
            $('.tab-contents').animate({
                'height': newheight+20
            }, 100);
            var otherindex = $(this).index();
            var substractindex = otherindex - newindex;
            var currentwidth = $('.multipletab').width();
            var newpositions = substractindex * currentwidth;
            $(this).animate({
                'left': newpositions
            });
        });
    };
    $.FindId = function () {
        $('.tab-contents>div').each(function () {
            if ($(this).attr('id') == $('.active').attr('id')) {
                $('.tab-contents>div').removeClass('activetab');
                $(this).addClass('activetab');
            }
        });
    };
    $('.tab-buttons>span').first().addClass('active');
    $('.tab-contents>div').each(function () {
        var activeid = $('.active').attr('id');
        if ($(this).attr('id') == activeid) {
            $(this).addClass('activetab');
        }
        var currentheight = $('.activetab').height();
        var currentwidth = $('.multipletab').width();
        var currentindex = $(this).index();
        var currentposition = currentindex * currentwidth;
        $(this).css({
            'left': currentposition,
                'width': currentwidth - 40,
                'padding': '10px 20px'
        });
        $(this).attr('data-position', currentposition);
        $('.tab-contents').css('height', currentheight+20);
    });
    $('.tab-buttons>span').click(function () {

        $('.tab-buttons>span').removeClass('active');
        $(this).addClass('active');
        var currentid = $('.active').attr('id');
        $.FindId();
        $.FindContainer();
    });
  //   $('.next').click(function () {
  //       var activetabindex = $('.activetab').index() + 1;
  //       var containers = $('.tab-content>div').length;
  //       if (containers == activetabindex) {
  //           $('.tab-buttons>span').removeClass('active');
  //           $('.tab-buttons>span').first().addClass('active');
  //           var currentid = $('.active').attr('id');
  //           $.FindId();
  //           $.FindContainer();
  //       } else {
  //           var currentopen = $('.active').next();
  //           $('.active').removeClass('active');
  //           currentopen.addClass('active');
  //           $.FindId();
  //           $.FindContainer();
  //       }
  //   });
  // $('.prev').click(function(){
  //   var activetabindex = $('.activetab').index();
  //       if (activetabindex == 0) {
  //           $('.tab-buttons>span').removeClass('active');
  //           $('.tab-buttons>span').last().addClass('active');
  //           var currentid = $('.active').attr('id');
  //           $.FindId();
  //           $.FindContainer();
  //       } else {
  //           var currentopen = $('.active').prev();
  //           $('.active').removeClass('active');
  //           currentopen.addClass('active');
  //           $.FindId();
  //           $.FindContainer();
  //       }
  // });
});
