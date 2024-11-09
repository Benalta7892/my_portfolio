document.addEventListener("turbo:load", () => {
  // Vérifie si le bouton "add-feature-btn" et la liste "features-list" existent
  const addFeatureBtn = document.getElementById("add-feature-btn");
  const featuresList = document.getElementById("features-list");

  // Exécute le code seulement si "add-feature-btn" est présent dans le DOM
  if (addFeatureBtn && featuresList) {
    addFeatureBtn.addEventListener("click", function () {
      const index = featuresList.children.length;
      const featureField = document.createElement("div");
      featureField.className = "feature-field";
      featureField.dataset.index = index;

      featureField.innerHTML = `
        <input type="text" name="project[features][]" class="form-control" placeholder="Fonctionnalité ${index + 1}">
        <button type="button" class="remove-feature-btn" onclick="removeFeature(this)">Retirer</button>
      `;

      featuresList.appendChild(featureField);
    });
  }
});

// Fonction globale pour retirer une fonctionnalité
function removeFeature(button) {
  const featureField = button.parentElement;
  featureField.style.display = "none";

  // Active le champ caché pour indiquer la suppression
  const hiddenInput = featureField.querySelector(".delete-feature");
  if (hiddenInput) {
    hiddenInput.disabled = false;
  }
}

// Rend la fonction accessible globalement pour inline HTML calls
window.removeFeature = removeFeature;
