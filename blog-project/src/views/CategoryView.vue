<template>
  <div class="category-view">
    <header class="category-header">
      <h1>Category: {{ categoryName }}</h1>
      <p>Showing {{ articles.length }} article(s) in this category</p>
    </header>
    
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
            class="category-link"
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
    
    <div v-if="articles.length === 0" class="no-articles">
      <h2>No articles found in this category</h2>
      <p>Check back later or browse other categories.</p>
      <router-link to="/">Back to Home</router-link>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import { useBlogStore } from '../stores/blog'

const route = useRoute()
const blogStore = useBlogStore()

const categoryName = computed(() => route.params.name)
const articles = computed(() => blogStore.getArticlesByCategory(categoryName.value))

const formatDate = (dateString) => {
  const options = { year: 'numeric', month: 'long', day: 'numeric' }
  return new Date(dateString).toLocaleDateString(undefined, options)
}
</script>

<style scoped>
.category-view {
  padding: 20px;
}

.category-header {
  text-align: center;
  margin-bottom: 40px;
  padding: 20px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  border-radius: 8px;
}

.category-header h1 {
  font-size: 2rem;
  margin-bottom: 10px;
  color: #333;
}

.category-header p {
  color: #666;
  font-size: 1.1rem;
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

.category-link {
  color: #42b883;
  text-decoration: none;
  font-weight: 500;
}

.category-link:hover {
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

.no-articles {
  text-align: center;
  padding: 60px 20px;
}

.no-articles h2 {
  font-size: 2rem;
  margin-bottom: 20px;
  color: #333;
}

.no-articles a {
  color: #42b883;
  text-decoration: none;
  font-weight: 500;
}

@media (max-width: 768px) {
  .category-header h1 {
    font-size: 1.5rem;
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