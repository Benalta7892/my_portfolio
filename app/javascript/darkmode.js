import { initVantaEffect } from "./vanta";

// Initialisation du mode sombre et des effets Vanta
document.addEventListener("turbo:load", () => {
  const darkModeEnabled = localStorage.getItem("darkMode") === "enabled";
  if (darkModeEnabled) {
    document.documentElement.classList.add("dark-mode");
    document.body.classList.add("dark-mode");
  } else {
    document.documentElement.classList.remove("dark-mode");
    document.body.classList.remove("dark-mode");
  }

  // Initialiser l'effet Vanta avec le thème actuel
  initVantaEffect();

  // Configuration du bouton de bascule de mode sombre
  const darkModeToggle = document.getElementById("dark-mode-toggle");
  if (darkModeToggle) {
    darkModeToggle.removeEventListener("click", toggleDarkMode);
    darkModeToggle.addEventListener("click", toggleDarkMode);
  }
});

// Fonction pour basculer le mode sombre
function toggleDarkMode() {
  document.documentElement.classList.toggle("dark-mode");
  document.body.classList.toggle("dark-mode");

  const darkModeEnabled = document.documentElement.classList.contains("dark-mode");
  localStorage.setItem("darkMode", darkModeEnabled ? "enabled" : "disabled");

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
