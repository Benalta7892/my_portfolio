// Importation des fichiers nécessaires pour les effets Vanta
import "https://cdnjs.cloudflare.com/ajax/libs/three.js/r124/three.min.js";
import "https://cdnjs.cloudflare.com/ajax/libs/vanta/0.5.21/vanta.clouds.min.js";
import "https://cdnjs.cloudflare.com/ajax/libs/vanta/0.5.21/vanta.birds.min.js";
import "https://cdnjs.cloudflare.com/ajax/libs/vanta/0.5.21/vanta.waves.min.js";
import "https://cdnjs.cloudflare.com/ajax/libs/vanta/0.5.21/vanta.net.min.js";

let vantaEffect;

// Configuration des couleurs pour les modes sombre et clair
const darkModeColors = {
  clouds: {
    backgroundColor: 0x1b1b1b,
    skyColor: 0x0a0a2e,
    cloudColor: 0x5a5a6e,
    cloudShadowColor: 0x1c1c1c,
    sunColor: 0xf5f3ce,
    sunGlareColor: 0xf5f3ce,
    sunlightColor: 0xb0b0b0,
  },
  birds: {
    backgroundColor: 0x0a0a2e,
    color1: 0x69ff,
    color2: 0xed54ed,
  },
  waves: {
    color: 0x2c3e50,
    waveHeight: 12,
    waveSpeed: 0.3,
  },
  net: {
    backgroundColor: 0x1b1b1b,
    color: 0x50596b,
  },
};

const lightModeColors = {
  clouds: {
    backgroundColor: 0xffffff,
    skyColor: 0x68b8d7,
    cloudColor: 0xadc1de,
    cloudShadowColor: 0x183550,
    sunColor: 0xff9919,
    sunGlareColor: 0xff6633,
    sunlightColor: 0xff9933,
  },
  birds: {
    backgroundColor: 0xebf8ff,
    color1: 0x4dbfe3,
    color2: 0xff3838,
  },
  waves: {
    color: 0x5d7591,
    waveHeight: 15,
    waveSpeed: 0.5,
  },
  net: {
    backgroundColor: 0xebf8ff,
    color: 0x5588,
  },
};

// Fonction pour vérifier si le mode sombre est activé
const isDarkMode = () => document.documentElement.classList.contains("dark-mode");

// Fonction d'initialisation de Vanta avec les couleurs adaptées
function initVantaEffect() {
  const vantaElement = document.getElementById("vantajs");

  if (!vantaElement) {
    if (vantaEffect) {
      vantaEffect.destroy();
      vantaEffect = null;
    }
    return;
  }

  // Détruire l'effet Vanta existant s'il y en a un
  if (vantaEffect) vantaEffect.destroy();

  const colors = isDarkMode() ? darkModeColors : lightModeColors;

  // Appliquer l'effet en fonction de la classe
  if (vantaElement.classList.contains("hero")) {
    vantaEffect = VANTA.CLOUDS({
      el: "#vantajs",
      mouseControls: true,
      touchControls: true,
      gyroControls: false,
      minHeight: 200.0,
      minWidth: 200.0,
      ...colors.clouds,
      speed: 0.42,
    });
  } else if (vantaElement.classList.contains("pages-page")) {
    vantaEffect = VANTA.BIRDS({
      el: "#vantajs",
      mouseControls: true,
      touchControls: true,
      gyroControls: false,
      minHeight: 200.0,
      minWidth: 200.0,
      ...colors.birds,
      colorMode: "lerp",
      birdSize: 0.8,
      wingSpan: 20,
      separation: 10,
      alignment: 20,
      cohesion: 20,
      quantity: 3.5,
    });
  } else if (vantaElement.classList.contains("projects-page")) {
    vantaEffect = VANTA.WAVES({
      el: "#vantajs",
      mouseControls: true,
      touchControls: true,
      gyroControls: false,
      minHeight: 200.0,
      minWidth: 200.0,
      ...colors.waves,
      scale: 1.0,
      scaleMobile: 1.0,
      shininess: 30,
      zoom: 0.65,
    });
  } else if (vantaElement.classList.contains("contacts-page")) {
    vantaEffect = VANTA.NET({
      el: "#vantajs",
      mouseControls: true,
      touchControls: true,
      gyroControls: false,
      minHeight: 200.0,
      minWidth: 200.0,
      ...colors.net,
      points: 20,
      maxDistance: 70,
      spacing: 90,
    });
  }
}

// Export pour permettre l'utilisation d'initVantaEffect dans d'autres fichiers
export { initVantaEffect };

// // Initialize Vanta effects and dark mode settings
// document.addEventListener("turbo:load", () => {
//   // Vérifie et applique le mode sombre lors du chargement d'une nouvelle page
//   const darkModeEnabled = localStorage.getItem("darkMode") === "enabled";
//   if (darkModeEnabled) {
//     document.documentElement.classList.add("dark-mode");
//     document.body.classList.add("dark-mode");
//   } else {
//     document.documentElement.classList.remove("dark-mode");
//     document.body.classList.remove("dark-mode");
//   }

//   // Initialiser l'effet Vanta avec les couleurs du thème actuel
//   initVantaEffect();

//   // Configuration du bouton de bascule de mode sombre
//   const darkModeToggle = document.getElementById("dark-mode-toggle");
//   if (darkModeToggle) {
//     darkModeToggle.removeEventListener("click", toggleDarkMode);
//     darkModeToggle.addEventListener("click", toggleDarkMode);
//   }
// });

// // Fonction pour basculer le mode sombre
// function toggleDarkMode() {
//   document.documentElement.classList.toggle("dark-mode");
//   document.body.classList.toggle("dark-mode");

//   const darkModeEnabled = document.documentElement.classList.contains("dark-mode");
//   localStorage.setItem("darkMode", darkModeEnabled ? "enabled" : "disabled");

//   // Réinitialiser l'effet Vanta pour refléter le changement de couleur
//   initVantaEffect();
// }

// // Avant que Turbo ne mette la page en cache, retirez la classe 'dark-mode' pour éviter les effets de cache
// document.addEventListener("turbo:before-cache", () => {
//   document.body.classList.remove("dark-mode");
// });
