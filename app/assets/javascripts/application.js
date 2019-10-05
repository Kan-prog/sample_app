// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require serviceworker-companion
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .
//= require bxslider
// 除去 require turbolinks//= require serviceworker-companion

// メインコンテンツをヘッダーの高さ分だけずらす
window.addEventListener('DOMContentLoaded', function(){
  var headerHeight = $('header').outerHeight();
  $('main').css('padding-top', headerHeight + 'px');
  $('#menu').css('margin-top', headerHeight + 'px');
  
  // MENUボタンがクリックされたときの処理
  $('.menu_btn').click(function(){
    console.log("clicked");
    if($(this).hasClass('active_menu')) {
      $(this).removeClass('active_menu');
      // $(this).text('MENU');
      $('#menu').removeClass('open');
      $('.menu-background').removeClass('open');
      console.log("activated");
    } else {
      $(this).addClass('active_menu');
      // $(this).text('×');
      $('#menu').addClass('open');
      $('.menu-background').addClass('open');
      console.log("fatal to activated");
    }
  });
  
  // メニューの背景がクリックされたときの処理
  $('.menu-background').click(function(){
    if($(this).hasClass('open')) {
      $(this).removeClass('open');
      // $('.menu_btn').removeClass('active_menu').text('MENU');
      $('.menu_btn').removeClass('active_menu');
      $('#menu').removeClass('open');
    }
  });
  

});  


