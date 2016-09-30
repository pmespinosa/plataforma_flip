# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $('#accordion').on 'shown.bs.collapse', (e) ->
    offset = $('.panel.panel-default > .panel-collapse.in').offset()
    if offset
      $('html,body').animate { scrollTop: $('.panel-title a').offset().top - 20 }, 500
    return
  return


$(document).ready ->
  #Check to see if the window is top if not then display button
  $(window).scroll ->
    if $(this).scrollTop() > 400
      $('.scrollToTop').fadeIn()
    else
      $('.scrollToTop').fadeOut()
    return
  #Click event to scroll to top
  $('.scrollToTop').click ->
    $('html, body').animate { scrollTop: 200 }, 800
    false
  return