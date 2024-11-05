function setupScrollButtons() {
  const scrollUpButton = document.getElementById("scroll-up");
  const scrollDownButton = document.querySelector('a[href="#first-section"]');

  function toggleScrollUpButton() {
    const scrollDownPosition = scrollDownButton.getBoundingClientRect().top;
    const scrollPosition = window.innerHeight + window.scrollY;
    const pageHeight = document.documentElement.scrollHeight;

    // Affiche le bouton "Remonter" lorsque "Descendre" est hors de vue ou si on est en bas de la page
    if (scrollDownPosition < 0 || scrollPosition >= pageHeight - 10) {
      scrollUpButton.classList.remove("hidden");
    } else {
      scrollUpButton.classList.add("hidden");
    }
  }

  // Défilement fluide pour les liens d'ancre
  document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
    anchor.addEventListener("click", function (event) {
      const targetId = this.getAttribute("href").substring(1);
      const targetElement = document.getElementById(targetId);

      if (targetElement) {
        event.preventDefault();
        const targetOffsetTop = targetElement.getBoundingClientRect().top + window.scrollY;
        const computedStyle = window.getComputedStyle(targetElement);
        const marginTop = parseFloat(computedStyle.marginTop);

        window.scrollTo({
          top: targetOffsetTop - marginTop,
          behavior: "smooth",
        });
      }
    });
  });

  // Surveille le défilement pour afficher ou masquer le bouton "Remonter"
  window.addEventListener("scroll", toggleScrollUpButton);
}

// Écoute `DOMContentLoaded` et `turbo:load`
document.addEventListener("DOMContentLoaded", setupScrollButtons);
document.addEventListener("turbo:load", setupScrollButtons);
