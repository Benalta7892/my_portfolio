document.addEventListener("turbo:load", function () {
  function setupTimeline(timelineClass, rondClass, boxClass, ligneClass) {
    const allRonds = document.querySelectorAll(rondClass);
    const allBoxes = document.querySelectorAll(boxClass);
    const ligne = document.querySelector(ligneClass);

    function updateTimeline() {
      const initialTop = 80;
      const spacing = 306;
      const boxTimelinePaddingTop = 80;

      if (window.innerWidth >= 374) {
        allBoxes.forEach((box, index) => {
          const topPosition = initialTop + index * spacing;
          box.style.top = `${topPosition}px`;

          if (window.innerWidth >= 1181) {
            box.style.left = index % 2 === 0 ? "calc(50% - 270px)" : "calc(50% + 270px)";
          } else {
            box.style.left = "";
          }

          const rond = allRonds[index];
          if (rond) {
            rond.style.top = `${topPosition}px`;
          }
        });
      }

      const firstRond = allRonds[0];
      const lastRond = allRonds[allRonds.length - 1];

      if (firstRond && lastRond) {
        const firstRondTop = firstRond.offsetTop + firstRond.offsetHeight / 2;
        const lastRondTop = lastRond.offsetTop + lastRond.offsetHeight / 2;
        ligne.style.height = `${lastRondTop - boxTimelinePaddingTop}px`;

        if (lastRondTop < firstRondTop) {
          ligne.style.height = `${firstRondTop}px`;
        }

        if (parseInt(ligne.style.height) < 230) {
          ligne.style.height = "230px";
        }
      }
    }

    updateTimeline();
    window.addEventListener("resize", updateTimeline);

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
  }

  setupTimeline(".parcours-timeline", ".parcours-rond", ".parcours-box", ".parcours-ligne");
  setupTimeline(".experience-timeline", ".experience-rond", ".experience-box", ".experience-ligne");
});
