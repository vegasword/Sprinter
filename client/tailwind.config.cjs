module.exports = {
  content: ["./src/*.{html,ts}"],
  theme: {
    extend: {},
  },
  plugins: [require("daisyui")],
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
