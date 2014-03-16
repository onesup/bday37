$(document).ready(function(){
  // _gaq.push(['_trackEvent', 'button', 'click', 'img down 1546']);
  // loadJsFile('http://i42.icast-ad.com/track?ccd=1242&mcd=01040601&pcd=1546');
  $('.select_custom_1').selectric();
  $('.select_custom_2').selectric();

  $("#gift_button").click(function(e){
    e.preventDefault();
    $("#popup_info").bPopup({
      modalColor: '#000'
    });
  });

  $("#popup_info_to_personal").click(function(e){
    e.preventDefault();
    $("#popup_personal").bPopup({
      closeClass: 'b-close-2',
      modalColor: '#000'
    });
  });

  $("#new_user").bind("ajax:success", function(evt,data,status,xhr){
    response = JSON.parse(xhr.responseText);
    if(response.status==="success"){
      $("#popup_fin1").bPopup({
        closeClass: 'b-close',
        modalColor: '#000',
        onClose: function(){$("#popup_info").bPopup().close();}
      });
    }else{
    }

  }).bind('ajax:error',function(evt,xhr,status,error){
    var $form = $(this),errors,errorText;
    errors = $.parseJSON(xhr.responseText);


    validation(errors);
  });

  $("#product_button").click(function(e){
    e.preventDefault();
    $("#popup_product").bPopup({
      modalColor: '#000'
    });
  });

  $("#info_input_radio").iCheck({
    checkboxClass: 'icheckbox_minimal',
    radioClass: 'iradio_minimal',
    increaseArea: '20%' // optional
  });
});

function validation(errors){
  if(Object.keys(errors).indexOf("phone") == -1){
    //폰없다
    for ( error in errors ) {
      $('input[data-name ='+error+']').parent().find('span').remove();
      $('input[data-name ='+error+']').after('<span class="star">*</span>');
      // $('input[data-name ='+error+']').next().empty('span');
    }
  }else{
    //폰있다
    if(errors.phone.indexOf("has already been taken") !=-1){
      //중복이다
      $("#popup_fin2").bPopup({
        closeClass: 'b-close',
        modalColor: '#000',
        onClose: function(){$("#popup_info").bPopup().close();}
      });
    }else{
      //중복 아니다
      for ( error in errors ) {
        $('input[data-name ='+error+']').parent().find('span').remove();
        $('input[data-name ='+error+']').after('<span class="star">*</span>');
        // $('input[data-name ='+error+']').next().empty('span');
      }
    }
  }
}
