$(document).ready(function() {
   $('.nav_bar').click(function(){
   $('.navigation').toggleClass('visible');
   $('body').toggleClass('opacity');
 });
 $('.plus a img').on('click', function () {
   console.log('plus clicked');
   $('.first-tab-at services-top services-top-toggle').toggle();
   $('.plus').hide();
   $('.minus').show();
 });
 $('.minus a img').on('click', function () {
   console.log('minus clicked');
   $('.first-tab-at services-top services-top-toggle').toggle();
   $('.minus').hide();
   $('.plus').show();
 });
});
