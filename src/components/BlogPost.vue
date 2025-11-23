<template>
  <div class="blog-post">
    <article class="post-content" v-if="post">
      <h1 class="post-title">{{ post.title }}</h1>
      <div class="post-meta">
        <p>By {{ post.author }} on {{ formatDate(post.date) }}</p>
      </div>
      <div class="post-body" v-html="formatContent(post.content)"></div>
      
      <div class="post-navigation">
        <router-link 
          v-if="prevPost" 
          :to="`/post/${prevPost.id}`" 
          class="nav-link prev"
        >
          ← {{ prevPost.title }}
        </router-link>
        
        <router-link to="/" class="nav-link home">Back to Home</router-link>
        
        <router-link 
          v-if="nextPost" 
          :to="`/post/${nextPost.id}`" 
          class="nav-link next"
        >
          {{ nextPost.title }} →
        </router-link>
      </div>
      
      <Comments :postId="post.id" />
    </article>
    
    <div v-else class="not-found">
      <h2>Post not found</h2>
      <p>The post you're looking for doesn't exist.</p>
      <router-link to="/">Back to Home</router-link>
    </div>
  </div>
</template>

<script>
import Comments from './Comments.vue';

export default {
  name: 'BlogPost',
  components: {
    Comments
  },
  props: ['id'],
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
  computed: {
    post() {
      return this.posts.find(p => p.id === parseInt(this.id))
    },
    prevPost() {
      if (!this.post) return null
      const currentIndex = this.posts.findIndex(p => p.id === this.post.id)
      return currentIndex > 0 ? this.posts[currentIndex - 1] : null
    },
    nextPost() {
      if (!this.post) return null
      const currentIndex = this.posts.findIndex(p => p.id === this.post.id)
      return currentIndex < this.posts.length - 1 ? this.posts[currentIndex + 1] : null
    }
  },
  methods: {
    formatDate(dateString) {
      const options = { year: 'numeric', month: 'long', day: 'numeric' }
      return new Date(dateString).toLocaleDateString(undefined, options)
    },
    formatContent(content) {
      // Simple markdown-like formatting for paragraphs
      return content
        .split('\n\n')
        .map(paragraph => `<p>${paragraph.trim()}</p>`)
        .join('')
    }
  }
}
</script>

<style scoped>
.blog-post {
  max-width: 800px;
  margin: 0 auto;
  padding: 2rem 1rem;
  background: white;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.post-title {
  font-size: 2.5rem;
  color: #333;
  margin-bottom: 1rem;
  line-height: 1.2;
}

.post-meta {
  color: #6c757d;
  font-size: 1rem;
  margin-bottom: 2rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #e9ecef;
}

.post-body {
  line-height: 1.8;
  color: #495057;
  font-size: 1.1rem;
}

.post-body p {
  margin-bottom: 1.5rem;
}

.post-navigation {
  margin-top: 3rem;
  padding-top: 2rem;
  border-top: 1px solid #e9ecef;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 1rem;
}

.nav-link {
  padding: 0.5rem 1rem;
  border: 1px solid #dee2e6;
  border-radius: 4px;
  text-decoration: none;
  color: #495057;
  transition: all 0.3s ease;
  flex: 1;
  text-align: center;
}

.nav-link:hover {
  background-color: #f8f9fa;
  border-color: #adb5bd;
}

.nav-link.prev {
  text-align: left;
}

.nav-link.next {
  text-align: right;
}

.nav-link.home {
  flex: 2;
}

.not-found {
  text-align: center;
  padding: 3rem 1rem;
}

.not-found h2 {
  margin-bottom: 1rem;
  color: #333;
}

.not-found a {
  color: #667eea;
  text-decoration: none;
  font-weight: 500;
}

.not-found a:hover {
  text-decoration: underline;
}

@media (max-width: 768px) {
  .blog-post {
    padding: 1rem;
  }
  
  .post-title {
    font-size: 2rem;
  }
  
  .post-navigation {
    flex-direction: column;
  }
  
  .nav-link {
    width: 100%;
  }
}
</style>