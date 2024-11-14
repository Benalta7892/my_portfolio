import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Swiper initialized");

    document.addEventListener("turbo:load", () => {
      this.initializeSwiper();
    });

    this.initializeSwiper();

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

    this.adjustContainerHeight(this.swiper2);
    this.applyObjectFit();

    this.swiper2.on("slideChangeTransitionEnd", () => {
      this.adjustContainerHeight(this.swiper2);
      this.applyObjectFit();
    });
  }

  adjustContainerHeight(swiperInstance) {
    const container = document.querySelector(".mySwiper2");
    const activeSlide = swiperInstance.slides[swiperInstance.activeIndex]?.querySelector("img");

    if (container && activeSlide) {
      container.style.height = "";

      const updateHeight = () => {
        container.style.height = `${activeSlide.offsetHeight}px`;

        if (activeSlide.naturalHeight > activeSlide.naturalWidth) {
          container.style.minHeight = "450px";
        } else {
          container.style.minHeight = "";
        }
      };

      if (!activeSlide.complete) {
        activeSlide.addEventListener("load", updateHeight);
      } else {
        updateHeight();
      }
    }
  }

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
