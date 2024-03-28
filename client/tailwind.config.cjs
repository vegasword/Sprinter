// DaisyUI modules import

module.exports = {
  content: ["./src/*.{html,ts}", "../node_modules/flowbite/**/*.js"], 
  theme: {
    extend: {
      backgroundImage: theme => ({
        'custom-gradient': 'linear-gradient(45deg, rgba(199,67,176,1) 0%, rgba(208,69,145,1) 32%, rgba(222,72,98,1) 83%)',
      })
    },
  },
  plugins: [require('flowbite/plugin'), require("daisyui")],
  daisyui: {
    themes: [
      {
        light: {
          ...require("daisyui/src/theming/themes")["light"],
          "primary": "#9f338a",
          "secondary": "#6D2D61",
          "accent": "#e30253",
          "neutral": "#9f338a",
          "base-100": "#ffffff",
        },
        business: {
          ...require("daisyui/src/theming/themes")["business"],
          "primary": "#9f338a",
          "secondary": "#6D2D61",
          "accent": "#e30253",
          "neutral": "#9f338a",
          "base-100": "#ffffff",
        }
      }
    ]
  }
}