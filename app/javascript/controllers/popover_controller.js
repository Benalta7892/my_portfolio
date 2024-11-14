import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content", "card"];

  connect() {
    console.log("Popover initialized");
    this.showTimeout = null;
    this.hideTimeout = null;
  }

  show() {
    console.log("Attempting to show popover");

    if (this.hideTimeout) {
      clearTimeout(this.hideTimeout);
    }

    if (this.hasContentTarget) {
      if (!this.hasCardTarget) {
        const card = this.contentTarget.content.cloneNode(true);
        this.element.appendChild(card);
      }

      if (this.hasCardTarget) {
        this.showTimeout = setTimeout(() => {
          this.cardTarget.classList.add("popover-visible");
          console.log("Popover displayed:", this.cardTarget);
        }, 200);
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
      clearTimeout(this.showTimeout);
    }

    this.hideTimeout = setTimeout(() => {
      if (this.hasCardTarget) {
        this.cardTarget.classList.remove("popover-visible");
        console.log("Popover hidden:", this.cardTarget);
      }
    }, 100);
  }
}
