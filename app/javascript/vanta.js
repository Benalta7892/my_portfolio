// Importation des fichiers nécessaires pour les effets Vanta
import "https://cdnjs.cloudflare.com/ajax/libs/three.js/r124/three.min.js";
import "https://cdnjs.cloudflare.com/ajax/libs/vanta/0.5.21/vanta.clouds.min.js";
import "https://cdnjs.cloudflare.com/ajax/libs/vanta/0.5.21/vanta.birds.min.js";
import "https://cdnjs.cloudflare.com/ajax/libs/vanta/0.5.21/vanta.waves.min.js";
import "https://cdnjs.cloudflare.com/ajax/libs/vanta/0.5.21/vanta.net.min.js";

let vantaEffect;

document.addEventListener("turbo:load", function () {
  const vantaElement = document.getElementById("vantajs");

  // Si l'élément n'existe pas, on ne lance pas Vanta
  if (!vantaElement) {
    if (vantaEffect) {
      vantaEffect.destroy();
      vantaEffect = null;
    }
    return;
  }

  // Détruire l'instance Vanta existante avant d'en créer une nouvelle
  if (vantaEffect) vantaEffect.destroy();

  // Appliquer l'effet Vanta en fonction de la classe de la page
  if (vantaElement.classList.contains("hero")) {
    vantaEffect = VANTA.CLOUDS({
      el: "#vantajs",
      mouseControls: true,
      touchControls: true,
      gyroControls: false,
      minHeight: 200.0,
      minWidth: 200.0,
      backgroundColor: 0xffffff,
      skyColor: 0x68b8d7,
      cloudColor: 0xadc1de,
      cloudShadowColor: 0x183550,
      sunColor: 0xff9919,
      sunGlareColor: 0xff6633,
      sunlightColor: 0xff9933,
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
      backgroundColor: 0xebf8ff,
      color1: 0x4dbfe3,
      color2: 0xff3838,
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
      scale: 1.0,
      scaleMobile: 1.0,
      color: 0x5d7591,
      shininess: 30,
      waveHeight: 15,
      waveSpeed: 0.5,
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
      color: 0x5588,
      backgroundColor: 0xebf8ff,
      points: 4,
      maxDistance: 18,
      spacing: 18,
    });
  }
});
