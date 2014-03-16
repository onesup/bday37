$(document).ready(function(){
  // ga(['_trackEvent', 'button', 'click', 'img down 1546']);
  // loadJsFile('http://i42.icast-ad.com/track?ccd=1242&mcd=01040601&pcd=1546');
  ga('send', 'event', 'button', 'click', '메인 페이지');
  $('.select_custom_1').selectric();
  $('.select_custom_2').selectric();

  $("#gift_button").click(function(e){
    e.preventDefault();
    $("#popup_info").bPopup({
      closeClass: 'b-close',
      modalColor: 'black'
    });
    ga('send', 'event', 'button', 'click', '생일 선물 받기');
  });

  $("#popup_info_to_personal").click(function(e){
    e.preventDefault();
    $("#popup_personal").bPopup({
      closeClass: 'b-close-2',
      modalColor: 'black'
    });
    ga('send', 'event', 'button', 'click', '개인정보 동의 팝업');
  });

  $("#new_user").bind("ajax:success", function(evt,data,status,xhr){
    response = JSON.parse(xhr.responseText);
    if(response.status==="success"){
      $("#popup_fin1").bPopup({
        closeClass: 'b-close',
        modalColor: 'black',
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
    ga('send', 'event', 'button', 'click', '제품 자세히 보기');

  });

  $("#info_input_radio").iCheck({
    checkboxClass: 'icheckbox_minimal',
    radioClass: 'iradio_minimal',
    increaseArea: '20%' // option
  });

  $("#info_phone").mask("999-9999-9999");

  // $('#info_phone').keyup(function(p_event){
  //   if( p_event.keyCode >= 48 && p_event.keyCode <= 57 ){
  //     var phoneNum = $('#info_phone').val();
  //     var returnNum = phoneNum;
  //
  //     while( true )
  //     {
  //       var findHP = phoneNum.search("-");
  //       if( findHP == -1 )
  //       {
  //         break;
  //       }
  //       else
  //       {
  //         var temp1 = phoneNum.substring(0, findHP);
  //         var temp2 = phoneNum.substring(findHP+1, phoneNum.length);
  //         phoneNum = temp1.concat(temp2);
  //       }
  //     }
  //
  //     if( phoneNum.substring(0, 2) == "01" )
  //     {
  //       if( phoneNum.length >= 11 )
  //       {
  //         var temp1 = phoneNum.substring(0, 3);
  //         var temp2 = phoneNum.substring(3, 7);
  //         var temp3 = phoneNum.substring(7, 11);
  //
  //         returnNum = temp1+"-"+temp2+"-"+temp3;
  //       }
  //       else if( phoneNum.length >= 7 )
  //       {
  //         var temp1 = phoneNum.substring(0, 3);
  //         var temp2 = phoneNum.substring(3, 6);
  //         var temp3 = phoneNum.substring(6, 10);
  //
  //         returnNum = temp1+"-"+temp2+"-"+temp3;
  //       }
  //       else if( phoneNum.length >= 4 )
  //       {
  //         var temp1 = phoneNum.substring(0, 3);
  //         var temp2 = phoneNum.substring(3, phoneNum.length);
  //
  //         returnNum = temp1+"-"+temp2;
  //       }
  //
  //       $('#info_phone').val(returnNum);
  //     }
  //   }
  // });
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
