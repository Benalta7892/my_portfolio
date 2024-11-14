function setupScrollButtons() {
  const scrollUpButton = document.getElementById("scroll-up");
  const scrollDownButton = document.querySelector('a[href="#first-section"]');
  const isAboutPage = document.body.classList.contains("about-page");

  function toggleScrollUpButton() {
    const scrollDownPosition = scrollDownButton.getBoundingClientRect().top;
    const scrollPosition = window.innerHeight + window.scrollY;
    const pageHeight = document.documentElement.scrollHeight;

    if (scrollDownPosition < 0 || scrollPosition >= pageHeight - 10) {
      scrollUpButton.classList.remove("hidden");
    } else {
      scrollUpButton.classList.add("hidden");
    }
  }

  document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
    anchor.addEventListener("click", function (event) {
      const targetId = this.getAttribute("href").substring(1);
      const targetElement = document.getElementById(targetId);

      if (targetElement) {
        event.preventDefault();
        const targetOffsetTop = targetElement.getBoundingClientRect().top + window.scrollY;
        const computedStyle = window.getComputedStyle(targetElement);
        const marginTop = parseFloat(computedStyle.marginTop);

        const offset = isAboutPage ? marginTop + 100 : marginTop;

        window.scrollTo({
          top: targetOffsetTop - offset,
          behavior: "smooth",
        });
      }
    });
  });

  window.addEventListener("scroll", toggleScrollUpButton);

  console.log("isAboutPage:", isAboutPage);
  console.log("marginTop:", marginTop);
  console.log("offset:", offset);
}

document.addEventListener("DOMContentLoaded", setupScrollButtons);
document.addEventListener("turbo:load", setupScrollButtons);
