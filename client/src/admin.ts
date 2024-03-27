const submitRequest = (e : SubmitEvent, route : string) => {
  e.preventDefault();
  
  const form : HTMLFormElement = (e.currentTarget as HTMLFormElement);
  const formData : FormData  = new FormData(form);
  let formStyle : CSSStyleDeclaration = (e.currentTarget as HTMLElement).style;
  
  const req = async () => {
    try {
      for (let [_, value] of formData) if (!value) throw("Invalid field(s)");      
      
      await fetch(
        `http://localhost:3000${route}/`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(Object.fromEntries(formData.entries()))
        }
      ).then((res : Response) => {
        if (res.status == 400) {
          formStyle.border = "1px solid red";
        } else {
          formStyle.border = "none";
          form.reset();
        }
      });
    } catch (error) {
      console.error("Request error: ", error);
    }
  };
  req();
};

document.getElementById("add-user")
        ?.addEventListener("submit",  (e) => 
          submitRequest(e, "/admin/addUser"));

document.getElementById("add-sprint")
        ?.addEventListener("submit",  (e) => 
          submitRequest(e, "/teacher/addSprint"));
