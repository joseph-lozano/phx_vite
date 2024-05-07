import { TanStackRouterVite } from "@tanstack/router-vite-plugin";
import react from "@vitejs/plugin-react";
import path from "path";
import { defineConfig } from "vite";

// https://vitejs.dev/config/
export default defineConfig(({ command }) => {
  const isDev = command !== "build";
  if (isDev) {
    process.stdin.on("close", () => process.exit(0));
    process.stdin.resume();
  }
  return {
    plugins: [react(), TanStackRouterVite()],
    resolve: {
      alias: {
        "~": path.resolve(__dirname, "./src"),
      },
    },
    build: {
      outDir: "../priv/static",
      copyPublicDir: false,
      emptyOutDir: true,
      manifest: true,
    },
    server: {
      host: true,
      port: 5173,
      strictPort: true,
      hmr: { port: 5174 },
      origin: "http://localhost:5173",
      proxy: {
        "/api": "http://localhost:4000",
        "/assets": "http://localhost:4000",
        "^/$": "http://localhost:4000",
      },
    },
  };
});
