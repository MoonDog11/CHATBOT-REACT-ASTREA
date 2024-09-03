import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000, // Asegúrate de que este puerto no esté en uso
  },
  build: {
    outDir: 'build', // Asegúrate de que este directorio esté bien configurado
  },
});
