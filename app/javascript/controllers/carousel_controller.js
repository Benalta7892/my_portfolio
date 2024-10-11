import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["slide"];

  connect() {
    // Récupère l'index stocké ou revient à 0
    const savedIndex = localStorage.getItem("carouselIndex");
    this.currentIndex = savedIndex ? parseInt(savedIndex) : 0;
    this.showCurrentSlide();
  }

  next() {
    this.hideCurrentSlide();
    this.currentIndex = (this.currentIndex + 1) % this.slideTargets.length;
    this.showCurrentSlide();
  }

  previous() {
    this.hideCurrentSlide();
    this.currentIndex = (this.currentIndex - 1 + this.slideTargets.length) % this.slideTargets.length;
    this.showCurrentSlide();
  }

  showCurrentSlide() {
    this.slideTargets.forEach((slide, index) => {
      slide.classList.toggle("hidden", index !== this.currentIndex);
    });
  }

  hideCurrentSlide() {
    this.slideTargets[this.currentIndex].classList.add("hidden");
  }

  saveCurrentIndex() {
    // Sauvegarder l'index de la slide actuelle dans le localStorage
    localStorage.setItem("carouselIndex", this.currentIndex);
  }
}
