function clearForm(){
 $('#article_title').val('');
 $('#article_text').val('');
 $('#error_explanation').html('');
 $('#results').html('');
}

$(function(){
  $('#clear').click(function(){
    clearForm();
  });
});
