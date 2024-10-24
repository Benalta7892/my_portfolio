import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content", "card"]; // Ajout de "content" en cible

  connect() {
    console.log("Popover initialized");
  }

  show() {
    console.log("Attempting to show popover");

    // Vérifier si le contenu du template est disponible
    if (this.hasContentTarget) {
      // Cloner le contenu du template s'il n'a pas été déjà inséré
      if (!this.hasCardTarget) {
        const card = this.contentTarget.content.cloneNode(true);
        this.element.appendChild(card);
      }

      // Afficher la carte si elle existe maintenant
      if (this.hasCardTarget) {
        this.cardTarget.style.display = "block";
        console.log("Popover displayed:", this.cardTarget);
      } else {
        console.error("cardTarget is not defined or found after cloning");
      }
    } else {
      console.error("Content template is missing");
    }
  }

  hide() {
    console.log("Hiding popover");
    if (this.hasCardTarget) {
      this.cardTarget.style.display = "none";
    }
  }
}
