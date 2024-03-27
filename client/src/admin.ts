const submitRequest = (e : SubmitEvent, route : string) => {
  e.preventDefault();
  
  const form = new FormData(e.currentTarget as HTMLFormElement);
  let formStyle = (e.currentTarget as HTMLElement).style;
  
  const req = async () => {
    try {
      for (let [_, value] of form) if (!value) throw("Invalid field");      
      
      await fetch(
        `http://localhost:3000${route}/`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(Object.fromEntries(form.entries()))
        }
      ).then((res : Response) => {
        if (res.status === 400) formStyle.border = "1px solid red";
        else formStyle.border = "1px solid green";
      });
    } catch (error) {
      console.error("Request error: ", error);
    }
  };
  req();
};

document.getElementById("add-people")
        ?.addEventListener("submit",  (e) => 
          submitRequest(e, "/admin/addPeople"));

document.getElementById("add-sprint")
        ?.addEventListener("submit",  (e) => 
          submitRequest(e, "/teacher/addSprint"));
