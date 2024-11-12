document.addEventListener("turbo:load", () => {
  const hamburgerToggler = document.querySelector(".hamburger");
  const navLinks = document.querySelector(".nav-links");
  const overlay = document.querySelector(".overlay"); // Sélection de l'overlay

  const toggleNav = () => {
    hamburgerToggler.classList.toggle("open");
    navLinks.classList.toggle("open");
    overlay.classList.toggle("open"); // Affiche l'overlay

    const ariaToggle = hamburgerToggler.getAttribute("aria-expanded") === "true" ? "false" : "true";
    hamburgerToggler.setAttribute("aria-expanded", ariaToggle);
  };

  // Ajoute l'événement de clic pour l'ouverture et la fermeture du menu
  hamburgerToggler.addEventListener("click", toggleNav);

  // Ajoute un événement de clic à l'overlay pour fermer le menu si on clique dessus
  overlay.addEventListener("click", toggleNav);

  new ResizeObserver((entries) => {
    if (entries[0].contentRect.width <= 650) {
      navLinks.style.transition = "transform 0.3s ease-out";
    } else {
      navLinks.style.transition = "none";
    }
  }).observe(document.body);
});
