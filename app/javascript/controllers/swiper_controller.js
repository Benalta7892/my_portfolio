import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="swiper"
export default class extends Controller {
  connect() {
    console.log("Swiper initialized");

    // Initialiser le carrousel lors du chargement de la page ou d'une navigation Turbo
    document.addEventListener("turbo:load", () => {
      this.initializeSwiper();
    });

    // Initialiser à la première connexion du contrôleur
    this.initializeSwiper();

    // Ajouter un écouteur pour ajuster les images lors du redimensionnement de la fenêtre
    window.addEventListener("resize", () => {
      this.applyObjectFit();
      this.adjustContainerHeight(this.swiper2);
    });
  }

  initializeSwiper() {
    const swiper = new Swiper(".mySwiper", {
      loop: true,
      spaceBetween: 10,
      slidesPerView: 4,
      freeMode: true,
      watchSlidesProgress: true,
    });

    this.swiper2 = new Swiper(".mySwiper2", {
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

    // Ajuster la hauteur initialement après la première initialisation
    this.adjustContainerHeight(this.swiper2);
    this.applyObjectFit();

    // Ajuster la hauteur lors des changements de slide
    this.swiper2.on("slideChangeTransitionEnd", () => {
      this.adjustContainerHeight(this.swiper2);
      this.applyObjectFit();
    });
  }

  // Fonction pour ajuster la hauteur du conteneur avec min-height conditionnelle
  adjustContainerHeight(swiperInstance) {
    const container = document.querySelector(".mySwiper2");
    const activeSlide = swiperInstance.slides[swiperInstance.activeIndex]?.querySelector("img");

    if (container && activeSlide) {
      // Réinitialiser la hauteur avant de définir la nouvelle
      container.style.height = "";

      // Mettre à jour la hauteur après le chargement de l'image active
      const updateHeight = () => {
        container.style.height = `${activeSlide.offsetHeight}px`;

        // Vérifie les dimensions de l'image et applique min-height si nécessaire
        if (activeSlide.naturalHeight > activeSlide.naturalWidth) {
          container.style.minHeight = "450px";
        } else {
          container.style.minHeight = ""; // Réinitialise min-height si la condition ne correspond pas
        }
      };

      // Écouter l'événement de chargement de l'image active
      if (!activeSlide.complete) {
        activeSlide.addEventListener("load", updateHeight);
      } else {
        updateHeight(); // Si l'image est déjà chargée
      }
    }
  }

  // Fonction pour appliquer l'objet fit en fonction de la hauteur de l'image et de la taille de l'écran
  applyObjectFit() {
    const images = document.querySelectorAll(".mySwiper2 img");
    images.forEach((img) => {
      if (window.innerWidth > 365 && img.offsetHeight > 290) {
        img.style.objectFit = "contain";
      } else {
        img.style.objectFit = "fill";
      }
    });
  }
}
