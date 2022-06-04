import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { itemId: Number }
  static targets = [ "icon" ]

  connect () {
    console.log(this.itemIdValue);
  }
}
