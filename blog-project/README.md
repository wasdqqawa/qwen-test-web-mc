# My Blog - Vue.js Blog Application

A modern, responsive blog application built with Vue 3, Vite, and Pinia. This application features article browsing, category filtering, search functionality, and responsive design suitable for deployment on GitHub Pages.

## Features

- **Article Management**: Browse, read, and search articles
- **Category Filtering**: Filter articles by category
- **Search Functionality**: Full-text search across articles
- **Responsive Design**: Works on mobile, tablet, and desktop
- **Markdown Support**: Articles written in Markdown format
- **Modern UI**: Clean, professional design with smooth interactions

## Technologies Used

- Vue 3 with Composition API
- Vite as build tool
- Vue Router for navigation
- Pinia for state management
- Markdown parser for content rendering
- CSS3 for styling and responsive design

## Deployment to GitHub Pages

This project is configured to be deployed on GitHub Pages:

1. Push your code to a GitHub repository
2. Enable GitHub Pages in your repository settings
3. Select the `gh-pages` branch or `/dist` folder as source
4. Your blog will be available at `https://<username>.github.io/<repository-name>/`

The project is already configured with the correct `base` path in `vite.config.js` for GitHub Pages deployment.

## Project Structure

```
src/
├── components/     # Reusable Vue components
├── views/          # Page components
├── stores/         # Pinia stores
├── router/         # Vue Router configuration
└── assets/         # Static assets
```

## Local Development

To run the project locally:

```bash
npm install
npm run dev
```

To build for production:

```bash
npm run build
```

The built files will be in the `dist/` directory.
