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
  }
}
