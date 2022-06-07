import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { itemId: Number }

  connect () {
    console.log(this.itemIdValue);
  }
}
