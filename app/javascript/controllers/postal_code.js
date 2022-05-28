import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  closeBtnPopup() {
    this.parentElement.parentElement.parentElement.style.display='none';
  }
}
