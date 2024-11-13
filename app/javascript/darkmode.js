import { initVantaEffect } from "./vanta";

// Initialisation du mode sombre et des effets Vanta
document.addEventListener("turbo:load", () => {
  const darkModeEnabled = localStorage.getItem("darkMode") === "enabled";
  const darkModeToggle = document.getElementById("btn-darkmode-toggle");

  if (darkModeEnabled) {
    document.documentElement.classList.add("dark-mode");
    document.body.classList.add("dark-mode");
    if (darkModeToggle) darkModeToggle.checked = true; // Coche le bouton si le mode sombre est activé
  } else {
    document.documentElement.classList.remove("dark-mode");
    document.body.classList.remove("dark-mode");
    if (darkModeToggle) darkModeToggle.checked = false; // Décoche le bouton pour le mode clair
  }

  // Initialiser l'effet Vanta avec le thème actuel
  initVantaEffect();

  // Écouter les changements sur le bouton de bascule
  if (darkModeToggle) {
    darkModeToggle.removeEventListener("change", toggleDarkMode);
    darkModeToggle.addEventListener("change", toggleDarkMode);
  }
});

// Fonction pour basculer le mode sombre
function toggleDarkMode(event) {
  const isChecked = event.target.checked;
  document.documentElement.classList.toggle("dark-mode", isChecked);
  document.body.classList.toggle("dark-mode", isChecked);

  // Stocker la préférence de mode sombre dans le localStorage
  localStorage.setItem("darkMode", isChecked ? "enabled" : "disabled");

  // Réinitialiser l'effet Vanta pour refléter le changement de couleur
  initVantaEffect();
}

// Avant que Turbo ne mette la page en cache, retirez la classe 'dark-mode' pour éviter les effets de cache
document.addEventListener("turbo:before-cache", () => {
  document.body.classList.remove("dark-mode");
});

// // Initialisation de Vanta à chaque chargement de page
// document.addEventListener("turbo:load", initVantaEffect);

// // Bascule de mode sombre/claire sans rechargement
// const darkModeToggle = document.getElementById("dark-mode-toggle");
// darkModeToggle.addEventListener("click", () => {
//   document.body.classList.toggle("dark-mode");

//   // Met à jour la préférence dans le localStorage
//   const darkModeEnabled = document.body.classList.contains("dark-mode");
//   localStorage.setItem("darkMode", darkModeEnabled ? "enabled" : "disabled");

//   // Réinitialise Vanta avec les couleurs du mode actuel
//   initVantaEffect();
// });

// // Charger la préférence utilisateur au démarrage
// document.addEventListener("DOMContentLoaded", () => {
//   if (localStorage.getItem("darkMode") === "enabled") {
//     document.body.classList.add("dark-mode");
//   }
//   initVantaEffect();
// });
