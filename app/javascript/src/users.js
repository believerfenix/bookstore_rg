$(document).on('turbolinks:load', function(){
  $(document).ready(function () {
    $('#Destroy_Account_Checkbox').click(function () {
      $('#Destroy_Account_Button').prop("disabled", !$("#Destroy_Account_Checkbox").prop("checked")); 
    })
  });
})
