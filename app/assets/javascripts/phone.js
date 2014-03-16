$(document).ready(function(){
  $("#info_input_radio").iCheck({
    checkboxClass: 'icheckbox_minimal',
    radioClass: 'iradio_minimal',
    increaseArea: '20%' // optional
  });

  $("#info_phone").mask("999-9999-9999");
});
