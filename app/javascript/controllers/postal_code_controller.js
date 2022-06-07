import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "@rails/ujs"


export default class extends Controller {
  static targets = [ "input", "submit", "popup" ]

  closeBtnPopup() {
    this.element.style.display='none';
    this.inputTarget.value = ''
  }

  connect() {
    this.inputTarget.value = ''
    this.showPopupOnLoad()
  }

  // Will show results when we send our location
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
          console.log(item)
          const itemCard = `<div class="card-product" data-id="${item[0].id}">
              <img src="https://raw.githubusercontent.com/lewagon/fullstack-images/master/uikit/skateboard.jpg" />
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
