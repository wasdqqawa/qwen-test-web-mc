<template>
  <div class="search-container">
    <div class="search-bar">
      <input 
        type="text" 
        v-model="searchQuery" 
        placeholder="Search blog posts..." 
        @input="performSearch"
        class="search-input"
      />
      <button @click="performSearch" class="search-button">
        <span>🔍</span>
      </button>
    </div>
    
    <div v-if="searchResults.length > 0" class="search-results">
      <h3>Search Results ({{ searchResults.length }})</h3>
      <div 
        v-for="post in searchResults" 
        :key="post.id" 
        class="search-result-item"
        @click="goToPost(post.id)"
      >
        <h4>{{ post.title }}</h4>
        <p>{{ post.excerpt }}</p>
        <small>By {{ post.author }} on {{ formatDate(post.date) }}</small>
      </div>
    </div>
    
    <div v-else-if="searchQuery && searchResults.length === 0" class="no-results">
      <p>No results found for "{{ searchQuery }}"</p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Search',
  data() {
    return {
      searchQuery: '',
      allPosts: [],
      searchResults: []
    }
  },
  mounted() {
    // 获取所有文章数据
    this.getAllPosts();
  },
  methods: {
    getAllPosts() {
      // 这里需要获取所有文章数据
      this.allPosts = [
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
      ];
    },
    performSearch() {
      if (!this.searchQuery.trim()) {
        this.searchResults = [];
        return;
      }
      
      const query = this.searchQuery.toLowerCase();
      
      this.searchResults = this.allPosts.filter(post => 
        post.title.toLowerCase().includes(query) || 
        post.excerpt.toLowerCase().includes(query) ||
        post.content.toLowerCase().includes(query)
      );
    },
    formatDate(dateString) {
      const options = { year: 'numeric', month: 'long', day: 'numeric' };
      return new Date(dateString).toLocaleDateString(undefined, options);
    },
    goToPost(id) {
      this.$router.push(`/post/${id}`);
      this.searchQuery = '';
      this.searchResults = [];
    }
  }
}
</script>

<style scoped>
.search-container {
  position: relative;
  margin-bottom: 1rem;
}

.search-bar {
  display: flex;
  border: 1px solid #ced4da;
  border-radius: 4px;
  overflow: hidden;
}

.search-input {
  flex: 1;
  padding: 0.75rem;
  border: none;
  outline: none;
  font-size: 1rem;
}

.search-button {
  padding: 0 1rem;
  background: #667eea;
  color: white;
  border: none;
  cursor: pointer;
  font-size: 1.2rem;
}

.search-button:hover {
  background: #5a6fd8;
}

.search-results {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: white;
  border: 1px solid #ced4da;
  border-radius: 4px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  z-index: 1000;
  max-height: 400px;
  overflow-y: auto;
}

.search-results h3 {
  padding: 1rem;
  margin: 0;
  background: #f8f9fa;
  border-bottom: 1px solid #dee2e6;
  border-radius: 4px 4px 0 0;
}

.search-result-item {
  padding: 1rem;
  border-bottom: 1px solid #dee2e6;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.search-result-item:hover {
  background-color: #f8f9fa;
}

.search-result-item:last-child {
  border-bottom: none;
}

.search-result-item h4 {
  margin: 0 0 0.5rem 0;
  color: #333;
}

.search-result-item p {
  margin: 0 0 0.5rem 0;
  color: #6c757d;
  font-size: 0.9rem;
}

.search-result-item small {
  color: #868e96;
  font-size: 0.8rem;
}

.no-results {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: white;
  border: 1px solid #ced4da;
  border-radius: 4px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  z-index: 1000;
  padding: 1rem;
}
</style>