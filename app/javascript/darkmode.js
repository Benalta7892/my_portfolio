import { initVantaEffect } from "./vanta";

document.addEventListener("turbo:load", () => {
  const darkModeEnabled = localStorage.getItem("darkMode") === "enabled";
  const darkModeToggle = document.getElementById("btn-darkmode-toggle");

  if (darkModeEnabled) {
    document.documentElement.classList.add("dark-mode");
    document.body.classList.add("dark-mode");
    if (darkModeToggle) darkModeToggle.checked = true;
  } else {
    document.documentElement.classList.remove("dark-mode");
    document.body.classList.remove("dark-mode");
    if (darkModeToggle) darkModeToggle.checked = false;
  }

  initVantaEffect();

  if (darkModeToggle) {
    darkModeToggle.removeEventListener("change", toggleDarkMode);
    darkModeToggle.addEventListener("change", toggleDarkMode);
  }
});

function toggleDarkMode(event) {
  const isChecked = event.target.checked;
  document.documentElement.classList.toggle("dark-mode", isChecked);
  document.body.classList.toggle("dark-mode", isChecked);

  localStorage.setItem("darkMode", isChecked ? "enabled" : "disabled");

  initVantaEffect();
}

document.addEventListener("turbo:before-cache", () => {
  document.body.classList.remove("dark-mode");
});
