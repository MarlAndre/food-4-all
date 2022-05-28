// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))

// Remove form PostalCode
const btn = document.getElementById('btn');

btn.addEventListener('click', function handleClick(event) {
  // 👇️ if you are submitting a form (prevents page reload)
  event.preventDefault();

  const postalCodeInput = document.getElementById('postal-code');

  // Send value to server
  console.log(postalCodeInput.value);

  // 👇️ clear input field
  postalCodeInput.value = '';
});
