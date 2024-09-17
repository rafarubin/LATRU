import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="animation"
export default class extends Controller {
  connect() {
    console.log("Hola soy Stimulus")
  }

  static targets = ["loader"]

  submit() {
    // Mostrar el loader cuando se envía el formulario
    this.loaderTarget.style.display = "block";
  }

  }
