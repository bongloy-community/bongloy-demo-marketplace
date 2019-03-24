$(document).ready(function(){
  $("#product_cover_product").on("change", function() {
    previewCoverProduct(this)
  })

  function previewCoverProduct(input) {
    console.log(input.files[0])
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function(e) {
        console.log(e.target.result)
        $("#image-preview").attr("src", e.target.result)
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
});
