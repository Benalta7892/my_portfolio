document.addEventListener("turbo:load", function () {
  const allRonds = document.querySelectorAll(".rond");
  const allBoxes = document.querySelectorAll(".box");

  const controller = new ScrollMagic.Controller();

  allBoxes.forEach((box) => {
    for (let i = 0; i < allRonds.length; i++) {
      if (allRonds[i].getAttribute("data-anim") === box.getAttribute("data-anim")) {
        let tween = gsap.from(box, { y: -50, opacity: 0, duration: 0.5 });

        let scene = new ScrollMagic.Scene({
          triggerElement: allRonds[i],
          reverse: false,
        })
          .setTween(tween)
          // .addIndicators() // Vous pouvez enlever cette ligne si vous ne voulez pas les indicateurs de débogage
          .addTo(controller);
      }
    }
  });

  console.log("Hello from scroll.js");
});
