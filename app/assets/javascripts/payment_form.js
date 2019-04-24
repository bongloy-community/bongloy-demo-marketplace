var publishableKey = document.head.querySelector("meta[name=bongloy-publishable-key]").content;
// var stripe = Stripe('pk_test_XmdOzADDVEtGSyVop5l3Ydpz');
var stripe = Stripe("pk_test_XmdOzADDVEtGSyVop5l3Ydpz")

var elements = stripe.elements();

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
// var card = elements.create('card', {style: style, hidePostalCode: true});

var cardNumberElement = elements.create('cardNumber', {
  style: style,
  placeholder: '1234 1234 1234 1234',
});
cardNumberElement.mount('#card-number');

var cardExpiryElement = elements.create('cardExpiry', {
  style: style,
  placeholder: 'MM / YY',
});
cardExpiryElement.mount('#card-expiry');

var cardCvcElement = elements.create('cardCvc', {
  style: style,
  placeholder: 'CVC',
});
cardCvcElement.mount('#card-cvc');

// card.mount('#card-element');

// card.addEventListener('change', function(event) {
//   var displayError = document.getElementById('card-errors');
//   if (event.error) {
//     displayError.textContent = event.error.message;
//   } else {
//     displayError.textContent = '';
//   }
// });

// var form = document.getElementById('payment-form');
var form = document.querySelector('[data-name="paymentForm"]');
form.addEventListener('submit', function(event) {
  event.preventDefault();

  stripe.createToken(cardNumberElement).then(function(result) {
    if (result.error) {
      var errorElement = document.getElementById('card-errors');
      errorElement.textContent = result.error.message;
    } else {
      stripeTokenHandler(result.token);
    }
  });
});

function stripeTokenHandler(token) {
  var hiddenInput = document.createElement('input');
  hiddenInput.setAttribute('type', 'hidden');
  hiddenInput.setAttribute('name', 'stripeToken');
  hiddenInput.setAttribute('value', token.id);
  form.appendChild(hiddenInput);

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
