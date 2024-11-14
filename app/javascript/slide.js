document.addEventListener("turbo:load", function () {
  console.log("Hello from slide.js");

  const carouselContainer = document.getElementById("carouselContainer");

  if (carouselContainer) {
    const carouselItems = carouselContainer.innerHTML;
    carouselContainer.innerHTML += carouselItems;

    let scrollLeft = 0;
    const scrollSpeed = 4;

    function animateCarousel(timestamp) {
      if (!lastTimestamp) {
        lastTimestamp = timestamp;
      }

      const deltaTime = timestamp - lastTimestamp;
      lastTimestamp = timestamp;

      scrollLeft += (scrollSpeed * deltaTime) / 60;
      if (scrollLeft >= carouselContainer.scrollWidth / 2) {
        scrollLeft = 0;
      }
      carouselContainer.style.transform = `translateX(-${scrollLeft}px)`;

      requestAnimationFrame(animateCarousel);
    }

    let lastTimestamp = null;
    requestAnimationFrame(animateCarousel);
  } else {
    console.log("Pas de slider logo pour le moment ici, ou pas... a voir");
  }
});
