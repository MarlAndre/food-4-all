import { Controller } from "@hotwired/stimulus"
import ContextExclusionPlugin from "webpack/lib/ContextExclusionPlugin";

export default class extends Controller {
  static targets = [ "icon" ]

  rose(event) {
    this.iconTarget.querySelector('i').classList.toggle('rose')
  }

  //Like button effects

  // red(".like").on("click", function () {
  //   setTimeout(function () {
  //     $(".like").fadeOut(100, function () {
  //       $(this).text("favorite_border").fadeIn(150);
  //     });
  //   }, 5000);

  //   $(".like").fadeOut(100, function () {
  //     $(this).text("favorite").fadeIn(150);
  //   });

  //   var $toastContent2 = $('<div class="flow-text">LIKED!</div>');
  //   Materialize.toast($toastContent2, 5000, "pink rounded");
  // }
}
