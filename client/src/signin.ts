import { io } from "socket.io-client";

const socket = io("http://localhost:3000");

const form = document.getElementById("sign-in");

form?.addEventListener("submit", (event) => {
  event.preventDefault();

  const email = document.getElementById("email") as HTMLInputElement;
  const password = document.getElementById("password") as HTMLInputElement;

  if (email !== undefined || password !== undefined) {
    if (!email.value.includes("esiee-it.fr")) {
      alert("L'email doit être un mail ESIEE valide !");
      //TODO: [FRONT] UI trigger
      return;
    }
    socket.emit("user:signin", email.value, password.value);
  }  
});

socket.on("user:signin:success", () => window.location.href="http://localhost:5173/src/dashboard.html");

