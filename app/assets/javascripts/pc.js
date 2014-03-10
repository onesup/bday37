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
        modalColor: '#000'
      });
    }else{
      alert("입력된 정보가 정확하지 않습니다. 입력 정보를 확인해주세요.");
    }
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