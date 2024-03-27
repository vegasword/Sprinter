document.getElementById("sign-in")?.addEventListener("submit", (event) => {
  event.preventDefault();

  const form = new FormData(event.currentTarget as HTMLFormElement);

  const req = async () => {
    try {
      await fetch(
        "http://localhost:3000/signin/",
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(Object.fromEntries(form.entries()))
        }
      ).then((res : Response) => {
        switch (res.status) {            
          case 200:
            window.location.assign(res.url);
            break;
          case 400:
            alert("Email ou mot de passe invalide");
            break;
        }
      });
    } catch (error) {
      console.error("Request error: ", error);
    }
  };
  req();
});
