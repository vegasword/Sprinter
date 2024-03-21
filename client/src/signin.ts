import { io } from "socket.io-client";

const socket = io("http://localhost:3000");

const form = document.getElementById("sign-in");

form?.addEventListener("submit", (event) => {
  event.preventDefault();

  const email = document.getElementById("email") as HTMLInputElement;
  const password = document.getElementById("password") as HTMLInputElement;

  if (email !== undefined || password !== undefined) {
    socket.emit("user:signin", email.value, password.value);
  }  
});

socket.on("user:signin:success", () => window.location.href="about:blank");

