<template>
  <div class="home">
    <section class="hero">
      <h1>Welcome to My Blog</h1>
      <p>A place to share thoughts, ideas, and experiences</p>
    </section>

    <section class="blog-posts">
      <div class="post-card" v-for="post in posts" :key="post.id">
        <h2 class="post-title">
          <router-link :to="`/post/${post.id}`">{{ post.title }}</router-link>
        </h2>
        <p class="post-meta">
          By {{ post.author }} on {{ formatDate(post.date) }}
        </p>
        <p class="post-excerpt">{{ post.excerpt }}</p>
        <router-link :to="`/post/${post.id}`" class="read-more">Read More</router-link>
      </div>
    </section>
  </div>
</template>

<script>
export default {
  name: 'Home',
  data() {
    return {
      posts: [
        {
          id: 1,
          title: 'Getting Started with Vue.js',
          excerpt: 'Vue.js is a progressive JavaScript framework for building user interfaces. It is designed to be incrementally adoptable...',
          date: '2025-01-15',
          author: 'Jane Doe',
          content: `Vue.js is a progressive JavaScript framework for building user interfaces. It is designed to be incrementally adoptable, meaning you can use as little or as much of Vue as you need. This makes it a great choice for both simple and complex applications.

Vue's core library focuses on the view layer only, making it easy to pick up and integrate with other libraries or existing projects. On the other hand, Vue is also perfectly capable of powering sophisticated Single-Page Applications when used in combination with supporting libraries and modern tooling.

One of the main advantages of Vue is its gentle learning curve. If you have experience with HTML, CSS, and JavaScript, you'll find Vue very approachable. Its template syntax allows you to declaratively render data to the DOM using simple syntax that extends HTML.

Vue also provides a component system that allows you to build encapsulated, reusable components that form a whole application. These components can be nested, composed, and managed independently, making it easier to develop and maintain large applications.`
        },
        {
          id: 2,
          title: 'Understanding Modern Web Development',
          excerpt: 'Modern web development involves various technologies and practices that have evolved significantly over the past few years...',
          date: '2025-01-10',
          author: 'John Smith',
          content: `Modern web development is a rapidly evolving field that encompasses a wide range of technologies, tools, and methodologies. Today's web developers need to be familiar with not just HTML, CSS, and JavaScript, but also frameworks, build tools, version control systems, and deployment strategies.

The rise of JavaScript frameworks like Vue, React, and Angular has transformed how we build web applications. These frameworks provide powerful tools for creating dynamic, interactive user interfaces while managing application state and data flow.

Additionally, modern web development emphasizes responsive design, accessibility, performance optimization, and cross-browser compatibility. With the increasing diversity of devices accessing the web, developers must ensure their applications work well across all platforms.

The development process has also become more sophisticated with tools like Webpack, Vite, and other build systems that handle bundling, minification, and optimization. These tools help developers create efficient applications that load quickly and provide a smooth user experience.`
        },
        {
          id: 3,
          title: 'The Future of Web Technologies',
          excerpt: 'As we look ahead, several emerging technologies are poised to reshape the web development landscape...',
          date: '2025-01-05',
          author: 'Alex Johnson',
          content: `The web development landscape is constantly evolving, with new technologies and trends emerging regularly. As we look toward the future, several key areas are likely to shape the direction of web development.

WebAssembly (WASM) is gaining traction as a way to run high-performance applications in the browser, potentially written in languages like C, C++, or Rust. This opens up possibilities for more complex applications that were previously only possible as native applications.

Progressive Web Apps (PWAs) continue to blur the lines between web and native applications, offering app-like experiences directly through the browser. They can be installed, work offline, and provide push notifications, making them an attractive alternative to traditional mobile apps.

Artificial Intelligence and Machine Learning are also making their way into web applications. With APIs and libraries like TensorFlow.js, developers can now integrate ML capabilities directly into their web applications without requiring server-side processing.

Serverless architectures and edge computing are changing how we think about backend infrastructure, allowing developers to focus on writing code rather than managing servers. These technologies are making web applications more scalable and cost-effective.`
        }
      ]
    }
  },
  methods: {
    formatDate(dateString) {
      const options = { year: 'numeric', month: 'long', day: 'numeric' }
      return new Date(dateString).toLocaleDateString(undefined, options)
    }
  }
}
</script>

<style scoped>
.hero {
  text-align: center;
  padding: 3rem 1rem;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border-radius: 8px;
  margin-bottom: 2rem;
}

.hero h1 {
  font-size: 2.5rem;
  margin-bottom: 1rem;
}

.hero p {
  font-size: 1.2rem;
  opacity: 0.9;
}

.blog-posts {
  display: grid;
  gap: 2rem;
}

.post-card {
  background: white;
  border-radius: 8px;
  padding: 1.5rem;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.post-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
}

.post-title {
  margin: 0 0 0.5rem 0;
}

.post-title a {
  color: #333;
  text-decoration: none;
  font-size: 1.5rem;
  font-weight: 600;
}

.post-title a:hover {
  color: #667eea;
}

.post-meta {
  color: #6c757d;
  font-size: 0.9rem;
  margin-bottom: 1rem;
}

.post-excerpt {
  color: #495057;
  line-height: 1.6;
  margin-bottom: 1rem;
}

.read-more {
  display: inline-block;
  color: #667eea;
  text-decoration: none;
  font-weight: 500;
}

.read-more:hover {
  text-decoration: underline;
}

@media (min-width: 768px) {
  .blog-posts {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 1024px) {
  .blog-posts {
    grid-template-columns: repeat(3, 1fr);
  }
}
</style>