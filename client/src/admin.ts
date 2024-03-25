import { io } from "socket.io-client";
import { IClientSockets } from "./sockets.interface";

const socket = io("http://localhost:3000");

const addProject = document.getElementById("add-project") as HTMLFormElement;
addProject?.addEventListener("submit", (event) => {
  event.preventDefault();
  
  const name = document.getElementById("project-name") as HTMLInputElement;
  const start = document.getElementById("project-start") as HTMLInputElement;
  const end = document.getElementById("project-end") as HTMLInputElement;
  const classroom = document.getElementById("project-classroom") as HTMLSelectElement;
  const techsList = document.getElementById("project-techs") as HTMLSelectElement;
  console.log(start.value, end.value);

  const nTechs : number = techsList.selectedOptions.length;
  if (!(nTechs > 0 && nTechs < 5)) {
    alert("Veuillez sélectionnez entre 1 et 5 technologies");
    return;
  }
  
  let techs : Array<string> = [];
  for (let tech of techsList.selectedOptions) techs.push(tech.value);
  if (name.value && start.value && end.value && classroom.value && techs) {
    const data : IClientSockets.Teacher.AddProject = {
      name: name.value,
      start: start.value,
      end: end.value,
      classroom: Number.parseInt(classroom.value),
      techs: techs
    } 
    socket.emit("teacher:addProject", data);
  }
});

