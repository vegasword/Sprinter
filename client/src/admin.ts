import { io } from "socket.io-client";
import { IClientSockets } from "./sockets.interface";

const socket = io("http://localhost:3000");

const addSprint = document.getElementById("add-sprint") as HTMLFormElement;
addSprint?.addEventListener("submit", (event : SubmitEvent) => {
  event.preventDefault();
  
  const name = document.getElementById("sprint-name") as HTMLInputElement;
  const start = document.getElementById("sprint-start") as HTMLInputElement;
  const end = document.getElementById("sprint-end") as HTMLInputElement;
  const classroom = document.getElementById("sprint-classroom") as HTMLSelectElement;
  const techsList = document.getElementById("sprint-techs") as HTMLSelectElement;

  const nTechs : number = techsList.selectedOptions.length;
  if (!(nTechs > 0 && nTechs < 5)) {
    alert("Veuillez sélectionnez entre 1 et 5 technologies");
    return;
  }
  
  let techs : Array<string> = [];
  for (let tech of techsList.selectedOptions) techs.push(tech.value);
  
  if (name.value && start.value && end.value && classroom.value && techs) {
    const data : IClientSockets.Teacher.AddSprint = {
      name: name.value,
      start: start.value,
      end: end.value,
      classroom_id: Number.parseInt(classroom.value),
      teacher_id: 2,
      techs: techs
    } 
    
    socket.emit("teacher:addSprint", data);
  }
});

