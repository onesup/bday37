$(document).ready(function(){
    // _gaq.push(['_trackEvent', 'button', 'click', 'img down 1546']);
    // loadJsFile('http://i42.icast-ad.com/track?ccd=1242&mcd=01040601&pcd=1546');
  $('#new_user').live('submit', function(e) {
    $.rails.handleRemote( $(this) );
    e.preventDefault();
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
