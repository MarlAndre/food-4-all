import { Controller } from "@hotwired/stimulus"
import ContextExclusionPlugin from "webpack/lib/ContextExclusionPlugin";

export default class extends Controller {
  static targets = [ "icon" ]

  red(event) {
    console.log("click");
    this.iconTarget.querySelector('i').classList.toggle('red')
  }
}
