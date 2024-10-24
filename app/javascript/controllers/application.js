import { Application } from "@hotwired/stimulus";
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers";

// Crée une instance de l'application Stimulus
const application = Application.start();

// Charge tous les contrôleurs présents dans le dossier controllers
const context = require.context("./controllers", true, /\.js$/);
application.load(definitionsFromContext(context));
