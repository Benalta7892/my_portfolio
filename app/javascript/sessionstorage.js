document.addEventListener("DOMContentLoaded", () => {
  const backButton = document.querySelector(".button-back");

  if (backButton) {
    backButton.addEventListener("click", (event) => {
      event.preventDefault();
      window.history.back();
    });
  }
});
