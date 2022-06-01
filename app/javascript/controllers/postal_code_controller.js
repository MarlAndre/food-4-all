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

    fetch(`items?${new URLSearchParams({ postal_code: this.inputTarget.value })}`,{
      method: "GET",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
    })

      .then(response => response.json())

      .then((items) => {
        const cardsItems = document.querySelector("#cards-items");
        cardsItems.innerHTML='';

        items.forEach((item) => {
          const itemCard = `<div class="card-product">
              <img src="https://raw.githubusercontent.com/lewagon/fullstack-images/master/uikit/skateboard.jpg" />
              <div class="card-product-infos">
                <h2>${item.name}</h2>

                <h3>${item.description}</h3>
                <p>"Montreal, Villeray-Saint-Michel-Parc-Extension"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <i class="fas fa-share-alt"></i></p>
              </div>
          </div>`
          cardsItems.insertAdjacentHTML("beforeend", itemCard)
        })
      })

      .finally(() => {
        this.element.style.display='none';
      })

  }

}
