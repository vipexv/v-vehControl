/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        border: "#454854",
        primary: "#353542",
        green: "#39ea49",
        yellow: "#fac536",
        red: "#f25056",
      },
    },
  },
  plugins: [],
};
