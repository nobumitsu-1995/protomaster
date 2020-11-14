$(function(){

  if($.cookie('close_header')){
      $('header').hide();
      $('#close_header').removeClass('fa-caret-square-left').addClass('fa-caret-square-right');
      $('.space_header').removeClass('open_header_padding');
    }

  $('#close_header').click(function(){
    var $accordion = $(this).parent().prev();
    if($.cookie('close_header')){
      $accordion.show();
      $('#close_header').removeClass('fa-caret-square-right').addClass('fa-caret-square-left');
      $('.space_header').addClass('open_header_padding');
      $.removeCookie('close_header',{path: '/'});
    }else{
      $accordion.hide();
      $('#close_header').removeClass('fa-caret-square-left').addClass('fa-caret-square-right');
      $('.space_header').removeClass('open_header_padding');
      $.cookie('close_header','close_header',{expires:1,path: "/"});
    }
  })

  $('.openarea').hover(function(){
    var $accordion = $(this).find(".accordion");
    var $icon = $(this).find('.icon-a');
    if($accordion.hasClass('open')){
      $accordion.removeClass('open');
      $accordion.slideUp();
      $icon.removeClass('fa-angle-up').addClass('fa-angle-down')
    }else{
      $accordion.addClass('open');
      $accordion.slideDown();
      $icon.removeClass('fa-angle-down').addClass('fa-angle-up');
    }
  });


  if($.cookie('close-left_btn')){
      $('.left').hide();
      $('.space_left').removeClass('open_left_padding');
      $('#close_left').removeClass('fa-caret-square-left').addClass('fa-caret-square-right');
    }

  $('#close_left').click(function(){
    var $accordion = $(this).parent().prev();
    if($.cookie('close-left_btn')){
      $accordion.show();
      $('#close_left').removeClass('fa-caret-square-right').addClass('fa-caret-square-left');
      $('.space_left').addClass('open_left_padding');
      $.removeCookie('close-left_btn',{path: '/'});
    }else{
      $accordion.hide();
      $('#close_left').removeClass('fa-caret-square-left').addClass('fa-caret-square-right');
      $('.space_left').removeClass('open_left_padding');
      $.cookie('close-left_btn','close-left_btn',{expires:1,path: "/"});
    }
  });


  $('.hide_number').hide();

  $('.open_proto').click(function(){
    var $accordion = $(this).nextUntil('.open_proto','.hide_number');
    if($accordion.hasClass('hide')){
      $accordion.slideDown();
      $accordion.removeClass('hide');
    }else{
      $accordion.slideUp();
      $accordion.addClass('hide');
    }
  });

  $('.hide_number2').hide();

  $('.open_proto2').click(function(){
    var $accordion = $(this).nextUntil('.open_proto2','.hide_number2');
    if($accordion.hasClass('hide')){
      $accordion.slideDown();
      $accordion.removeClass('hide');
    }else{
      $accordion.slideUp();
      $accordion.addClass('hide');
    }
  });

  $('.delete_alert').click(function(){
    if(!confirm('削除してよろしいですか？')){
      return false;
    }else{
      return true;
    }
  });

  $('#delete_user').click(function(){
    $('#modal_background').show();
  })

  $('#close_modal').click(function(){
    $('#modal_background').slideUp();
  })

});
