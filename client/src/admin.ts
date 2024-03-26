document.getElementById("add-sprint")?.addEventListener("submit", (e) => {
  e.preventDefault();
  
  const data = new FormData(e.currentTarget as HTMLFormElement);
  

  const addSprint = async () => {
    try {
      const req = await fetch(
        "http://localhost:3000/teacher/addSprint/",
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(Object.fromEntries(data.entries()))
        }
      );
      const res = await req.json();
      console.log(res);
    } catch (error) {
      console.error("Error:", error);
    }
  }
  
  addSprint();
  
  /*
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
  */
});

