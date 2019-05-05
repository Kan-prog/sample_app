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
//= require rails-ujs
//= require jquery
//= require bootstrap
//= require turbolinks
//= require_tree .
//= require bxslider
// $(document).ready(function() {
//   // 名前がクリックされたら
//   $(".search").click(function() {
//     // プロフィールコンテンツを選択
//     var content = $(".search_block");
//     // プロフィールコンテンツが非表示の場合は
//     if (!content.is(":visible")) {
//       // プロフィールコンテンツを表示
//       content.slideDown();
//     //   $("#tag").html("▲");
//     }
//     return false;
//   });
//   // プロフィールコンテンツ以外がクリックされたら
//   // $("div:not(.search_block)").click(function() {
//     $('div[class!="search_block"]').click(function() {
//       var content = $(".search_block");
//       // プロフィールコンテンツが表示されている場合は
//       if (content.is(":visible")) {
//         // プロフィールコンテンツを非表示
//         content.slideUp();
//       //   $("#tag").html("▼");
//       }
//   });
// });
