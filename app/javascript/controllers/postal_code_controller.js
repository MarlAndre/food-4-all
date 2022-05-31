import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"


export default class extends Controller {
  static targets = [ "input", "submit" ]

  closeBtnPopup() {
    this.element.style.display='none';
    this.inputTarget.value = ''
  }

  connect() {
    this.inputTarget.value = ''
  }

 // Find a way to send params (form input) to fetch.
  submitForm(event) {
    event.preventDefault()

    fetch(this.element.formAction  + new URLSearchParams({ postal_code: this.inputTarget.value }),{
      method: "GET",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })
  }

}
