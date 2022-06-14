import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['popup']

  connect() {
    if (localStorage.getItem('postal_code')) {
      this.popupTarget.classList.add('d-none')
    } else {
      this.popupTarget.classList.remove('d-none')
    }
  }

  remove() {
    const inputField = document.getElementById('postal_code')
    localStorage.setItem('postal_code', inputField.value)
  }
}
