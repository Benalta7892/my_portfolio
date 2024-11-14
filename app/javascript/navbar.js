document.addEventListener("turbo:load", () => {
  const hamburgerToggler = document.querySelector(".hamburger");
  const navLinks = document.querySelector(".nav-links");
  const overlay = document.querySelector(".overlay");

  const toggleNav = () => {
    hamburgerToggler.classList.toggle("open");
    navLinks.classList.toggle("open");
    overlay.classList.toggle("open");

    const ariaToggle = hamburgerToggler.getAttribute("aria-expanded") === "true" ? "false" : "true";
    hamburgerToggler.setAttribute("aria-expanded", ariaToggle);
  };

  hamburgerToggler.addEventListener("click", toggleNav);

  overlay.addEventListener("click", toggleNav);

  new ResizeObserver((entries) => {
    if (entries[0].contentRect.width <= 650) {
      navLinks.style.transition = "transform 0.3s ease-out";
    } else {
      navLinks.style.transition = "none";
    }
  }).observe(document.body);
});
