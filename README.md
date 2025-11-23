# Vue Blog for GitHub Pages

A modern, responsive blog built with Vue 3 and Vite, optimized for deployment on GitHub Pages. This project includes advanced features like post navigation, search functionality, categories, comments, and a responsive design.

## Features

- **Responsive Design**: Works on mobile, tablet, and desktop devices
- **Blog Posts**: View and navigate between blog posts with next/previous navigation
- **Search Functionality**: Search through blog posts by title, content, or excerpt
- **Categories**: Browse posts by category with filtering capability
- **Comments System**: Interactive comment system with replies and likes
- **Sidebar**: Includes recent posts, popular posts, and tags
- **Modern UI**: Clean and attractive user interface
- **Static File Deployment**: Optimized for GitHub Pages hosting

## Local Development

1. Install dependencies:
```bash
npm install
```

2. Start development server:
```bash
npm run dev
```

## Deploying to GitHub Pages

### Method 1: Using gh-pages (Recommended)

1. Modify the `base` option in `vite.config.js` to match your repository name:
```js
export default defineConfig({
  // ...
  base: '/your-repository-name/', // Replace with your GitHub repository name
  // ...
})
```

2. Build the project:
```bash
npm run build
```

3. Deploy to GitHub Pages:
```bash
npm run deploy
```

### Method 2: Using GitHub Actions (Recommended for automated deployment)

Create a `deploy.yml` file in the `.github/workflows` directory:

```yml
name: Build and Deploy

on:
  push:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout
      uses: actions/checkout@v3

    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '20'

    - name: Install dependencies
      run: npm install

    - name: Build
      run: npm run build

    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./dist
        publish_branch: gh-pages
```

## Project Structure

```
src/
├── components/
│   ├── About.vue          # About page component
│   ├── BlogPost.vue       # Individual blog post view with comments
│   ├── Category.vue       # Category browsing component
│   ├── Comments.vue       # Comments system component
│   ├── Contact.vue        # Contact page component with form
│   ├── Home.vue           # Main home page with posts and sidebar
│   ├── Search.vue         # Search functionality component
│   └── Sidebar.vue        # Sidebar with recent/popular posts and tags
├── App.vue               # Main application component with navigation
├── main.js               # Vue application entry and router configuration
└── assets/               # Static assets
```

## Customization

You can easily customize the blog:

1. Modify `src/components/Home.vue` to change the home page content
2. Update `src/components/About.vue` for the about page
3. Update `src/components/Contact.vue` for the contact page
4. Add more blog posts in `src/components/BlogPost.vue` and `src/components/Home.vue`
5. Add new categories in `src/components/Category.vue`
6. Update navigation links in `src/App.vue`
7. Modify styling in the `<style>` tags of each component
