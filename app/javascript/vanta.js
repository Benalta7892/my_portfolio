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
    color: 0x5588,
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
      points: 30,
      maxDistance: 70,
      spacing: 80,
    });
  }
}

// Export pour permettre l'utilisation d'initVantaEffect dans d'autres fichiers
export { initVantaEffect };
