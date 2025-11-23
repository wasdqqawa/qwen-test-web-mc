<template>
  <div class="category-container">
    <h2>Categories</h2>
    <div class="category-list">
      <div 
        v-for="category in categories" 
        :key="category.id"
        class="category-item"
        :class="{ active: selectedCategory === category.id }"
        @click="selectCategory(category.id)"
      >
        <span class="category-name">{{ category.name }}</span>
        <span class="post-count">({{ category.count }})</span>
      </div>
    </div>
    
    <div v-if="selectedCategory !== null" class="category-posts">
      <h3>{{ getCategoryName(selectedCategory) }} Posts</h3>
      <div class="post-grid">
        <div 
          v-for="post in filteredPosts" 
          :key="post.id" 
          class="post-card"
          @click="goToPost(post.id)"
        >
          <h4 class="post-title">{{ post.title }}</h4>
          <p class="post-meta">By {{ post.author }} on {{ formatDate(post.date) }}</p>
          <p class="post-excerpt">{{ post.excerpt }}</p>
        </div>
      </div>
    </div>
    
    <div v-else class="all-posts">
      <h3>All Posts</h3>
      <div class="post-grid">
        <div 
          v-for="post in allPosts" 
          :key="post.id" 
          class="post-card"
          @click="goToPost(post.id)"
        >
          <h4 class="post-title">{{ post.title }}</h4>
          <p class="post-meta">By {{ post.author }} on {{ formatDate(post.date) }}</p>
          <p class="post-excerpt">{{ post.excerpt }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Category',
  data() {
    return {
      selectedCategory: null,
      categories: [
        { id: 1, name: 'Vue.js', count: 1 },
        { id: 2, name: 'Web Development', count: 1 },
        { id: 3, name: 'Future Tech', count: 1 },
        { id: 4, name: 'Tutorials', count: 2 },
        { id: 5, name: 'JavaScript', count: 2 }
      ],
      allPosts: [
        {
          id: 1,
          title: 'Getting Started with Vue.js',
          excerpt: 'Vue.js is a progressive JavaScript framework for building user interfaces. It is designed to be incrementally adoptable...',
          date: '2025-01-15',
          author: 'Jane Doe',
          categoryIds: [1, 4, 5],
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
          categoryIds: [2, 4, 5],
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
          categoryIds: [3],
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
    filteredPosts() {
      if (this.selectedCategory === null) {
        return this.allPosts;
      }
      return this.allPosts.filter(post => 
        post.categoryIds.includes(this.selectedCategory)
      );
    }
  },
  methods: {
    selectCategory(categoryId) {
      this.selectedCategory = this.selectedCategory === categoryId ? null : categoryId;
    },
    getCategoryName(categoryId) {
      const category = this.categories.find(cat => cat.id === categoryId);
      return category ? category.name : '';
    },
    formatDate(dateString) {
      const options = { year: 'numeric', month: 'long', day: 'numeric' };
      return new Date(dateString).toLocaleDateString(undefined, options);
    },
    goToPost(id) {
      this.$router.push(`/post/${id}`);
    }
  }
}
</script>

<style scoped>
.category-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem 1rem;
}

.category-container h2 {
  margin-bottom: 1.5rem;
  color: #333;
}

.category-list {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  margin-bottom: 2rem;
}

.category-item {
  padding: 0.5rem 1rem;
  background: #e9ecef;
  border-radius: 20px;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 0.25rem;
}

.category-item:hover {
  background: #dee2e6;
}

.category-item.active {
  background: #667eea;
  color: white;
}

.category-name {
  font-weight: 500;
}

.post-count {
  font-size: 0.8rem;
}

.category-posts, .all-posts {
  margin-top: 2rem;
}

.category-posts h3, .all-posts h3 {
  margin-bottom: 1.5rem;
  color: #333;
}

.post-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 1.5rem;
}

.post-card {
  background: white;
  border-radius: 8px;
  padding: 1.5rem;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  cursor: pointer;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.post-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
}

.post-title {
  margin: 0 0 0.5rem 0;
  color: #333;
  font-size: 1.2rem;
}

.post-meta {
  color: #6c757d;
  font-size: 0.8rem;
  margin-bottom: 0.5rem;
}

.post-excerpt {
  color: #495057;
  line-height: 1.6;
  margin-bottom: 0;
}

@media (max-width: 768px) {
  .post-grid {
    grid-template-columns: 1fr;
  }
  
  .category-container {
    padding: 1rem;
  }
}
</style>