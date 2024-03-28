// Récupère le bouton de fermeture et le modal
let closeModalBtn = document.getElementById("closeModalBtn");
let modal = document.getElementById("crud-modal");
let modalForm = document.querySelector("#crud-modal form");
let sprintClassSelect = document.getElementById("sprintClassSelect");

// Associe un gestionnaire d'événements à la soumission du formulaire
modalForm.addEventListener("submit", function(event) {
    // Empêche le formulaire de se soumettre
    event.preventDefault();
    
    // Vérifie si tous les champs requis sont remplis
    let formIsValid = true;
    modalForm.querySelectorAll('input[required], select[required]').forEach(function(element) {
        if (!element.value.trim()) {
            formIsValid = false;
        }
    });

    // Vérifie si l'option sélectionnée n'est pas la première (placeholder) et n'est pas désactivée
    if (sprintClassSelect.selectedIndex === 0 || sprintClassSelect.options[sprintClassSelect.selectedIndex].disabled) {
        sprintClassSelect.setCustomValidity("Veuillez sélectionner une classe valide."); // La sélection n'est pas valide
        formIsValid = false;
    } else {
        sprintClassSelect.setCustomValidity(""); // La sélection est valide
    }

    // Si tous les champs sont remplis, ferme le modal
    if (formIsValid) {
        modal.classList.add("hidden"); // Ajoute la classe "hidden" pour cacher le modal
    } else {
        // Sinon, affiche un message d'erreur ou effectue une autre action
        alert("Veuillez remplir tous les champs obligatoires.");
    }
});

// Réinitialise la validité du champ lorsque la sélection change
sprintClassSelect.addEventListener("change", function() {
    if (sprintClassSelect.selectedIndex !== 0 && !sprintClassSelect.options[sprintClassSelect.selectedIndex].disabled) {
        sprintClassSelect.setCustomValidity("");
    } else {
        sprintClassSelect.setCustomValidity("Veuillez sélectionner une classe.");
    }
});
