// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-fileupload
//= require bootstrap-sprockets
//= require jquery_ujs
//= require cocoon
//= require turbolinks
//= require_tree .

$(function() {
  $('#pictureInput_1').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();
      img.style.height = '100px';
      img.style.width = '100px';
      console.log(file);
      img.src = file.target.result;
      $('#target_1').html(img);
    }
    reader.readAsDataURL(image);
    console.log(files);
  });
});

$(function() {
  $('#pictureInput_2').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();
      img.style.height = '100px';
      img.style.width = '100px';
      console.log(file);
      img.src = file.target.result;
      $('#target_2').html(img);
    }
    reader.readAsDataURL(image);
    console.log(files);
  });
});


var autosave = window.setInterval("autosaveForm()", 15000);

function autosaveForm() {
  $('form[data-remote]').submit();
}
