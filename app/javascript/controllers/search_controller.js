// app/javascript/controllers/search_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]
  static values = { productId: Number }

  connect() {
    this.timeout = null
  }

  search() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      const query = this.inputTarget.value
      const url = `/courses/search?product_id=${this.productIdValue}&q=${encodeURIComponent(query)}`

      fetch(url, { headers: { Accept: "text/vnd.turbo-stream.html" } })
        .then(response => response.text())
        .then(html => {
          document.getElementById("courses_list").innerHTML = html
        })
    }, 500)
  }
}

