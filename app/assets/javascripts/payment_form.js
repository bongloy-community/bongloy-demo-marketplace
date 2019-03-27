var publishableKey = document.head.querySelector("meta[name=bongloy-publishable-key]").content;
//Bongloy.setPublishableKey(publishableKey);
var stripe = Stripe('pk_test_XmdOzADDVEtGSyVop5l3Ydpz');

// Create an instance of Elements.
var elements = stripe.elements();

// Custom styling can be passed to options when creating an Element.
// (Note that this demo uses a wider set of styles than the guide below.)
var style = {
  base: {
    color: '#32325d',
    fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
    fontSmoothing: 'antialiased',
    fontSize: '16px',
    '::placeholder': {
      color: '#aab7c4'
    }
  },
  invalid: {
    color: '#fa755a',
    iconColor: '#fa755a'
  }
};

// Create an instance of the card Element.
var card = elements.create('card', {style: style});

// Add an instance of the card Element into the `card-element` <div>.
card.mount('#card-element');

// Handle real-time validation errors from the card Element.
card.addEventListener('change', function(event) {
  var displayError = document.getElementById('card-errors');
  if (event.error) {
    displayError.textContent = event.error.message;
  } else {
    displayError.textContent = '';
  }
});

// Handle form submission.
var form = document.getElementById('payment-form');
form.addEventListener('submit', function(event) {
  event.preventDefault();

  stripe.createToken(card).then(function(result) {
    if (result.error) {
      // Inform the user if there was an error.
      var errorElement = document.getElementById('card-errors');
      errorElement.textContent = result.error.message;
    } else {
      // Send the token to your server.
      stripeTokenHandler(result.token);
    }
  });
});

// Submit the form with the token ID.
function stripeTokenHandler(token) {
  // Insert the token ID into the form so it gets submitted to the server
  var form = document.getElementById('payment-form');
  var hiddenInput = document.createElement('input');
  hiddenInput.setAttribute('type', 'hidden');
  hiddenInput.setAttribute('name', 'stripeToken');
  hiddenInput.setAttribute('value', token.id);
  form.appendChild(hiddenInput);

  // Submit the form
  form.submit();
}

//var checkoutForm = document.querySelector('[data-name="paymentForm"]');
//checkoutForm.addEventListener('submit', submitHandler, false);

//// Submit handler for checkout form.
//function submitHandler(event) {
  //event.preventDefault();

  //var expiry = document.querySelector('[data-name="cardExpiry"]').value.split("/");

  //var card_number = document.querySelector('[data-name="cardNumber"]');
  //var card_expiry = "01/20";
  //var card_cvc = document.querySelector('[data-name="cardCVC"]');

  //var elements = Stripe.elements();

  //var card = elements.create('card');

  //var cardNumber = elements.create('cardNumber');
  //cardNumber.mount(card_number)
  //var cardExpiry = elements.create('cardExpiry');
  //cardExpiry.mount(card_expiry)
  //var cardCvc = elements.create('cardCvc');
  //cardCvc.mount(card_cvc)

  //console.log(card);

  //Stripe.createToken(card).then(function(result){
    //console.log(result)
  //})


  //Stripe.createToken(card, function(statusCode, response) {
//var errorMessages = document.querySelector('[data-name="errorMessages"]'); //errorMessages.classList.remove('d-block');
    //errorMessages.classList.add('d-none');

    //console.log(response);
    //console.log(statusCode);

    //if (statusCode === 201) {
      //// On success, set token in your checkout form
      //document.querySelector('[data-name="cardToken"]').value = response.id;

      //// Then, submit the form
      //checkoutForm.submit();
    //}
    //else {
      //// If unsuccessful, display an error message.
      //// Note that `response.error.message` contains a preformatted error message.
      //document.querySelector("input[type=submit]").removeAttribute('disabled');
      //errorMessages.classList.remove('d-none');
      //errorMessages.classList.add('d-block');
      //errorMessages.innerHTML = response.error.message;
    //}

  //});

  //var expiry = document.querySelector('[data-name="cardExpiry"]').value.split("/");
  //var cardObject = {
    //// The HTML in this example uses `data-name` attribute instead of the HTML name attribute to prevent sending credit card information fields to the backend server via HTTP POST

    //number:     document.querySelector('[data-name="cardNumber"]').value,
    //exp_month:  expiry[0],
    //exp_year:   expiry[1],
    //cvc:        document.querySelector('[data-name="cardCVC"]').value
    //// exp_month: document.querySelector('[data-name="expMonth"]').value,
    //// exp_year:  document.querySelector('[data-name="expYear"]').value,

    //// The `cardObject` above requires both `exp_month` and `exp_year`. In our HTML, we could have two separate fields to capture both the expiry month and the expiry year with selectors such as `data-name="expMonth"` and `data-name="expYear"`. In this example however, we are using the `jessepollak/card` library (https://github.com/jessepollak/card) which has only has one field for the card expiry.
  //};

  //console.log(cardObject);

  //Stripe.createToken('card', cardObject, function(statusCode, response) {
    //// hide error messages
    //var errorMessages = document.querySelector('[data-name="errorMessages"]');
    //errorMessages.classList.remove('d-block');
    //errorMessages.classList.add('d-none');

    //console.log(response);
    //console.log(statusCode);

    //if (statusCode === 201) {
      //// On success, set token in your checkout form
      //document.querySelector('[data-name="cardToken"]').value = response.id;

      //// Then, submit the form
      //checkoutForm.submit();
    //}
    //else {
      //// If unsuccessful, display an error message.
      //// Note that `response.error.message` contains a preformatted error message.
      //document.querySelector("input[type=submit]").removeAttribute('disabled');
      //errorMessages.classList.remove('d-none');
      //errorMessages.classList.add('d-block');
      //errorMessages.innerHTML = response.error.message;
    //}
  //});
