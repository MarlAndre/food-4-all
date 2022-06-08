import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"


export default class extends Controller {
  static targets = [ "input", "submit", "popup" ]

  // closeBtnPopup() {
  //   this.element.style.display='none';
  //   this.inputTarget.value = ''
  // }

  connect() {
    this.inputTarget.value = ''
    this.showPopupOnLoad()
  }

  // Will show results when we send our location
  submitForm(event) {
    event.preventDefault()
    window.location.href="items";

    fetch(`items?${new URLSearchParams({ postal_code: this.inputTarget.value })}`,{
      method: "GET",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
    })

      .then(response => response.json())

      .then((items) => {
        const cardsItems = document.querySelector("#cards-items");
        cardsItems.innerHTML='';

        // This needs to be updated
        items.forEach((item) => {
          const itemCard = `<div class="card-product" data-id="${item[0].id}">
              <img src="https://images.unsplash.com/photo-1554136383-fa88b2d86aaf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80" />
              <div class="card-product-infos">
                <h2>${item[0].name}</h2>

                <h3>${item[0].description}</h3>
                <p>${item[1]}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <i class="fas fa-share-alt"></i></p>
              </div>
          </div>`
          cardsItems.insertAdjacentHTML("beforeend", itemCard)

        })
        const cards = document.querySelectorAll(".card-product")
        cards.forEach(card => {
          card.addEventListener("click", () =>{
            window.location.href = window.location.origin + "/items/" + card.dataset.id
          })
        })

      })
      .catch(e => console.log('error', e.message))

      .finally(() => {
        this.element.style.display='none';
      })
  }
  // show PopUp once per session
  showPopupOnLoad() {
    if (!localStorage.getItem('isPopUpSeen')) {
        this.popupTarget.style.display = 'flex'
        localStorage.setItem('isPopUpSeen', 'true')
    }
  }
}
