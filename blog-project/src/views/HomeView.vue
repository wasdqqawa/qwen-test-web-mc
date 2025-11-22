<template>
  <div class="home">
    <section class="hero">
      <h1>Welcome to My Blog</h1>
      <p>A place for thoughts, ideas, and stories about web development and technology.</p>
    </section>
    
    <section class="articles">
      <h2>Latest Articles</h2>
      <div class="article-grid">
        <article 
          v-for="article in articles" 
          :key="article.id" 
          class="article-card"
        >
          <div class="article-header">
            <h3>
              <router-link :to="{ name: 'article', params: { id: article.id } }">
                {{ article.title }}
              </router-link>
            </h3>
            <span class="date">{{ formatDate(article.date) }}</span>
          </div>
          <p class="excerpt">{{ article.excerpt }}</p>
          <div class="article-meta">
            <span class="author">By {{ article.author }}</span>
            <router-link 
              :to="{ name: 'category', params: { name: article.category } }" 
              class="category"
            >
              {{ article.category }}
            </router-link>
          </div>
          <div class="tags">
            <span 
              v-for="tag in article.tags" 
              :key="tag" 
              class="tag"
            >
              #{{ tag }}
            </span>
          </div>
        </article>
      </div>
    </section>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useBlogStore } from '../stores/blog'

const blogStore = useBlogStore()
const articles = computed(() => blogStore.articles)

const formatDate = (dateString) => {
  const options = { year: 'numeric', month: 'long', day: 'numeric' }
  return new Date(dateString).toLocaleDateString(undefined, options)
}
</script>

<style scoped>
.hero {
  text-align: center;
  padding: 40px 20px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  border-radius: 8px;
  margin-bottom: 40px;
}

.hero h1 {
  font-size: 2.5rem;
  margin-bottom: 15px;
  color: #333;
}

.hero p {
  font-size: 1.2rem;
  color: #666;
  max-width: 600px;
  margin: 0 auto;
}

.articles h2 {
  font-size: 1.8rem;
  margin-bottom: 25px;
  color: #333;
  padding-bottom: 10px;
  border-bottom: 2px solid #42b883;
}

.article-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 30px;
}

.article-card {
  background: white;
  border-radius: 8px;
  padding: 25px;
  box-shadow: 0 4px 6px rgba(0,0,0,0.1);
  transition: transform 0.3s, box-shadow 0.3s;
}

.article-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0,0,0,0.15);
}

.article-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 15px;
}

.article-header h3 {
  margin: 0;
  flex: 1;
}

.article-header h3 a {
  color: #333;
  text-decoration: none;
  font-size: 1.4rem;
  transition: color 0.3s;
}

.article-header h3 a:hover {
  color: #42b883;
}

.date {
  color: #999;
  font-size: 0.9rem;
  white-space: nowrap;
  margin-left: 15px;
}

.excerpt {
  color: #666;
  line-height: 1.6;
  margin-bottom: 15px;
}

.article-meta {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;
  font-size: 0.9rem;
  color: #888;
}

.author {
  font-style: italic;
}

.category {
  color: #42b883;
  text-decoration: none;
  font-weight: 500;
}

.category:hover {
  text-decoration: underline;
}

.tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.tag {
  background-color: #eef7f0;
  color: #42b883;
  padding: 4px 10px;
  border-radius: 20px;
  font-size: 0.8rem;
  cursor: pointer;
}

@media (max-width: 768px) {
  .hero h1 {
    font-size: 2rem;
  }
  
  .article-grid {
    grid-template-columns: 1fr;
  }
  
  .article-header {
    flex-direction: column;
    gap: 10px;
  }
}
</style>