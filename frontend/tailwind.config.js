/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
    "../lib/phx_vite_web/**/*.html.heex",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
