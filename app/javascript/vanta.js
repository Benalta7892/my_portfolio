import "https://cdnjs.cloudflare.com/ajax/libs/three.js/r134/three.min.js";
import "https://cdnjs.cloudflare.com/ajax/libs/vanta/0.5.21/vanta.clouds.min.js";

let vantaEffectClouds;

document.addEventListener("turbo:load", function () {
  // Détruire l'instance Vanta existante s'il y en a une
  if (vantaEffectClouds) vantaEffectClouds.destroy();

  // Initialiser l'animation des nuages
  vantaEffectClouds = VANTA.CLOUDS({
    el: "#vantajs", // Sélecteur de l'élément cible pour les nuages
    mouseControls: true,
    touchControls: true,
    gyroControls: false,
    minHeight: 200.0,
    minWidth: 200.0,
    backgroundColor: 0xffffff, // Couleur de fond
    skyColor: 0x68b8d7, // Couleur du ciel
    cloudColor: 0xadc1de, // Couleur des nuages
    cloudShadowColor: 0x183550, // Couleur des ombres des nuages
    sunColor: 0xff9919, // Couleur du soleil
    sunGlareColor: 0xff6633, // Couleur de l'éclat du soleil
    sunlightColor: 0xff9933, // Couleur de la lumière solaire
    speed: 0.42, // Vitesse de l'animation
  });
});
