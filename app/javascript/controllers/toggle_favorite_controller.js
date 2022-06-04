import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "icon" ]

  red(event) {
    if (this.iconTarget.classList.contains('red')) {
      this.iconTarget.classList.remove('red');
    } else {
      this.iconTarget.classList.add('red');
    }
    console.log(this.iconTarget)
  }
}
