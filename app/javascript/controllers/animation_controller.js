import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="animation"
export default class extends Controller {
  connect() {
    console.log("Hola soy Stimulus")
  }

  static targets = ["loader"]

  submit() {
    this.showLoader()
  }

  showLoader() {
    this.loaderTarget.style.display = "block"
  }
  }
