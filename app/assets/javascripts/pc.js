$(document).ready(function(){
    // _gaq.push(['_trackEvent', 'button', 'click', 'img down 1546']);
    // loadJsFile('http://i42.icast-ad.com/track?ccd=1242&mcd=01040601&pcd=1546');
    /*
  $('#new_user').live('submit', function(e) {
    $.rails.handleRemote( $(this) );
    e.preventDefault();
  });
  */

  // by Kyoseung
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
});


$.rails.fire = function(obj, name, data) {
  var event = $.Event(name);

  // Custom code:
  // e.g. "Fire ajax:before for my-form!"
  console.log("Fire " + name + " for " + obj.attr('id') + "!");

  obj.trigger(event, data);
  return event.result !== false;
};
