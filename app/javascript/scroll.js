document.addEventListener("turbo:load", function () {
  const allRonds = document.querySelectorAll(".rond");
  const allBoxes = document.querySelectorAll(".box");
  const ligne = document.querySelector(".ligne");

  function updateTimeline() {
    const initialTop = 80; // Position top de la première boîte/rond
    const spacing = 306; // Espace total (hauteur de la boîte + hauteur du rond)

    // Ajustement des boîtes et de leur positionnement
    allBoxes.forEach((box, index) => {
      const topPosition = initialTop + index * spacing; // Calcul de la position top
      box.style.top = `${topPosition}px`; // Positionne les boîtes

      // Appliquer les classes 'left' ou 'right' en fonction de la largeur de l'écran
      if (window.innerWidth >= 1181) {
        // Positionner selon l'index
        box.style.left =
          index % 2 === 0 // Si l'index est pair
            ? "calc(50% - 270px)" // Position à gauche pour les index pairs
            : "calc(50% + 270px)"; // Position à droite pour les index impairs
      } else {
        // Retirer la propriété left pour que le CSS prenne le relais
        box.style.left = "";
      }

      // Mettre à jour la position top du rond correspondant
      const rond = allRonds[index];
      if (rond) {
        rond.style.top = `${topPosition}px`; // Positionne les ronds
      }
    });

    // Ajustement de la hauteur de la ligne
    const firstRond = allRonds[0]; // Premier rond
    const lastRond = allRonds[allRonds.length - 1]; // Dernier rond

    if (firstRond && lastRond) {
      const firstRondTop = firstRond.offsetTop; // Top du premier rond
      const lastRondTop = lastRond.offsetTop; // Top du dernier rond

      // Ajuste la hauteur de la ligne pour qu'elle soit égale au dernier rond
      ligne.style.height = `${lastRondTop}px`; // Met à jour la hauteur à celle du dernier rond

      // Vérification de la largeur de l'écran pour ajuster la hauteur
      if (window.innerWidth < 550) {
        ligne.style.height = `${lastRondTop - 20}px`; // Réduit de 20px si inférieur à 550px
      }

      // Si le top du dernier rond est inférieur à celui du premier rond, le conserver à cette valeur
      if (lastRondTop < firstRondTop) {
        ligne.style.height = `${firstRondTop}px`; // Force la hauteur à celle du premier rond si nécessaire
      }
    }
  }

  // Appel initial pour définir la taille
  updateTimeline();

  // Écouteur d'événements pour gérer les changements de taille de la fenêtre
  window.addEventListener("resize", updateTimeline);

  // Contrôleur ScrollMagic
  const controller = new ScrollMagic.Controller();

  allBoxes.forEach((box, index) => {
    const rond = allRonds[index];

    let tween = gsap.from(box, { y: -50, opacity: 0, duration: 0.5 });

    let scene = new ScrollMagic.Scene({
      triggerElement: rond,
      reverse: false,
    })
      .setTween(tween)
      .addTo(controller);
  });

  console.log("Hello from scroll.js");
});
