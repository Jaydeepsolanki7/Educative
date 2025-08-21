import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  toggle() {
    console.log("Menu toggle clicked")
    this.menuTarget.classList.toggle("hidden")
  }
}
