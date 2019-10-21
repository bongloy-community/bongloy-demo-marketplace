var publishableKey = document.head.querySelector("meta[name=bongloy-publishable-key]").content;
var bongloyAccount= document.getElementById("bongloy-account-id").value;

Bongloy.setPublishableKey(publishableKey, { bongloyAccount: bongloyAccount });

var checkoutForm = document.querySelector('[data-name="paymentForm"]');
checkoutForm.addEventListener('submit', submitHandler, false);

function submitHandler(event) {
  event.preventDefault();

  var expiry = document.querySelector('[data-name="cardExpiry"]').value.split("/");
  var cardObject = {

    number:     document.querySelector('[data-name="cardNumber"]').value,
    exp_month:  expiry[0],
    exp_year:   expiry[1],
    cvc:        document.querySelector('[data-name="cardCVC"]').value
  };

  Bongloy.createToken('card', cardObject, function(statusCode, response) {
    var errorMessages = document.querySelector('[data-name="errorMessages"]');
    errorMessages.classList.remove('d-block');
    errorMessages.classList.add('d-none');

    if (statusCode === 201) {
      document.querySelector('[data-name="cardToken"]').value = response.id;

      checkoutForm.submit();
    }
    else {
      document.querySelector("input[type=submit]").removeAttribute('disabled');
      errorMessages.classList.remove('d-none');
      errorMessages.classList.add('d-block');
      errorMessages.innerHTML = response.error.message;
    }
  });
}

