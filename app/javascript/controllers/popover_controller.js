import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content", "card"];

  connect() {
    console.log("Popover initialized");
    this.showTimeout = null; // Pour stocker le timeout de show
    this.hideTimeout = null; // Pour stocker le timeout de hide
  }

  show() {
    console.log("Attempting to show popover");

    if (this.hideTimeout) {
      clearTimeout(this.hideTimeout); // Annuler la tentative de cacher si elle est en cours
    }

    if (this.hasContentTarget) {
      if (!this.hasCardTarget) {
        const card = this.contentTarget.content.cloneNode(true);
        this.element.appendChild(card);
      }

      if (this.hasCardTarget) {
        // Ajoutez un léger délai pour éviter le spam de l'événement
        this.showTimeout = setTimeout(() => {
          this.cardTarget.classList.add("popover-visible"); // Ajoute la classe pour l'afficher avec la transition
          console.log("Popover displayed:", this.cardTarget);
        }, 200); // Un petit délai pour initier l'affichage
      } else {
        console.error("cardTarget is not defined or found after cloning");
      }
    } else {
      console.error("Content template is missing");
    }
  }

  hide() {
    console.log("Hiding popover");

    if (this.showTimeout) {
      clearTimeout(this.showTimeout); // Annuler la tentative d'afficher si elle est en cours
    }

    this.hideTimeout = setTimeout(() => {
      if (this.hasCardTarget) {
        this.cardTarget.classList.remove("popover-visible"); // Retire la classe pour cacher avec transition
        console.log("Popover hidden:", this.cardTarget);
      }
    }, 100); // Un délai léger avant de cacher l'élément
  }
}
