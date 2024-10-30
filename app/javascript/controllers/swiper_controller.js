import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="swiper"
export default class extends Controller {
  connect() {
    console.log("Swiper initialized");

    // Utiliser Swiper directement
    const swiper = new Swiper(".mySwiper", {
      loop: true,
      spaceBetween: 10,
      slidesPerView: 4,
      freeMode: true,
      watchSlidesProgress: true,
    });
    const swiper2 = new Swiper(".mySwiper2", {
      loop: true,
      spaceBetween: 10,
      navigation: {
        nextEl: ".btn-carousel-next",
        prevEl: ".btn-carousel-prev",
      },
      thumbs: {
        swiper: swiper,
      },
    });
    // Ajuster la hauteur du conteneur Swiper en fonction de l'image active
    swiper2.on("slideChange", function () {
      const activeSlide = swiper2.slides[swiper2.activeIndex].querySelector("img");
      if (activeSlide) {
        const container = document.querySelector(".mySwiper2");
        container.style.height = `${activeSlide.offsetHeight}px`;
      }
    });

    // Définir la hauteur initiale
    const initialSlide = swiper2.slides[swiper2.activeIndex].querySelector("img");
    if (initialSlide) {
      const container = document.querySelector(".mySwiper2");
      container.style.height = `${initialSlide.offsetHeight}px`;
    }
  }
}
