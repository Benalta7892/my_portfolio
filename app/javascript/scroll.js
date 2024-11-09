document.addEventListener("turbo:load", function () {
  const allRonds = document.querySelectorAll(".rond");
  const allBoxes = document.querySelectorAll(".box");
  const ligne = document.querySelector(".ligne");

  function updateTimeline() {
    const initialTop = 80; // Initial top position for the first box/rond
    const spacing = 306; // Total spacing (box height + rond height)
    const boxTimelinePaddingTop = 80; // Top padding for .box-timeline

    // Position adjustments for screens above 374px
    if (window.innerWidth >= 374) {
      allBoxes.forEach((box, index) => {
        const topPosition = initialTop + index * spacing;
        box.style.top = `${topPosition}px`; // Set top position of boxes

        // Apply 'left' or 'right' class based on screen width and index
        if (window.innerWidth >= 1181) {
          box.style.left =
            index % 2 === 0
              ? "calc(50% - 270px)" // Left position for even indices
              : "calc(50% + 270px)"; // Right position for odd indices
        } else {
          box.style.left = ""; // Reset left property for CSS fallback
        }

        // Update the top position of the corresponding rond
        const rond = allRonds[index];
        if (rond) {
          rond.style.top = `${topPosition}px`;
        }
      });
    }

    // Calculate and set the line height based on the ronds' positions
    const firstRond = allRonds[0];
    const lastRond = allRonds[allRonds.length - 1];

    if (firstRond && lastRond) {
      const firstRondTop = firstRond.offsetTop + firstRond.offsetHeight / 2;
      const lastRondTop = lastRond.offsetTop + lastRond.offsetHeight / 2;

      // Update ligne height based on the last rond's position
      ligne.style.height = `${lastRondTop - boxTimelinePaddingTop}px`;

      // Ensure the line height is not smaller than the first rond's top position
      if (lastRondTop < firstRondTop) {
        ligne.style.height = `${firstRondTop}px`;
      }

      // Set a minimum line height of 230px
      if (parseInt(ligne.style.height) < 230) {
        ligne.style.height = "230px";
      }
    }
  }

  // Initial call to set up the timeline
  updateTimeline();

  // Event listener for window resize
  window.addEventListener("resize", updateTimeline);

  // ScrollMagic controller setup
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
///
