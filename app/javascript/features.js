document.addEventListener("turbo:load", () => {
  const addFeatureBtn = document.getElementById("add-feature-btn");
  const featuresList = document.getElementById("features-list");

  if (addFeatureBtn && featuresList) {
    addFeatureBtn.addEventListener("click", function () {
      const index = featuresList.children.length;
      const featureField = document.createElement("div");
      featureField.className = "feature-field";
      featureField.dataset.index = index;

      featureField.innerHTML = `
        <input type="text" name="project[features][]" class="form-control" placeholder="Fonctionnalité ${index + 1}">
        <button type="button" class="remove-feature-btn button" onclick="removeFeature(this)">Retirer</button>
      `;

      featuresList.appendChild(featureField);
    });
  }
});

function removeFeature(button) {
  const featureField = button.parentElement;
  featureField.style.display = "none";

  const hiddenInput = featureField.querySelector(".delete-feature");
  if (hiddenInput) {
    hiddenInput.disabled = false;
  }
}

window.removeFeature = removeFeature;
