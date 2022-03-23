$(document).on('turbolinks:load', function(){
  $(document).ready(function () {
    $('#Delstroy_Account_Checkbox').click(function () {
      $('#Delstroy_Account_Button').prop("disabled", !$("#Delstroy_Account_Checkbox").prop("checked")); 
    })
  });
})
