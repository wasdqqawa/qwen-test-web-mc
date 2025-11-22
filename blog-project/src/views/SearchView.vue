<template>
  <div class="search-view">
    <header class="search-header">
      <h1>Search Results</h1>
      <p v-if="query">
        Showing {{ results.length }} result(s) for "{{ query }}"
      </p>
    </header>
    
    <div v-if="!query" class="search-prompt">
      <h2>No search query provided</h2>
      <p>Please enter a search term in the search box.</p>
      <router-link to="/">Back to Home</router-link>
    </div>
    
    <div v-else-if="results.length === 0" class="no-results">
      <h2>No results found</h2>
      <p>Try searching for something else.</p>
      <router-link to="/">Back to Home</router-link>
    </div>
    
    <div v-else class="results-grid">
      <article 
        v-for="article in results" 
        :key="article.id" 
        class="result-card"
      >
        <div class="result-header">
          <h3>
            <router-link :to="{ name: 'article', params: { id: article.id } }">
              {{ article.title }}
            </router-link>
          </h3>
          <span class="date">{{ formatDate(article.date) }}</span>
        </div>
        <p class="excerpt">{{ highlightText(article.excerpt) }}</p>
        <div class="result-meta">
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
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import { useBlogStore } from '../stores/blog'

const route = useRoute()
const blogStore = useBlogStore()

const query = computed(() => route.query.q)
const results = computed(() => {
  if (!query.value) return []
  return blogStore.searchArticles(query.value)
})

const formatDate = (dateString) => {
  const options = { year: 'numeric', month: 'long', day: 'numeric' }
  return new Date(dateString).toLocaleDateString(undefined, options)
}

const highlightText = (text) => {
  if (!query.value) return text
  
  const regex = new RegExp(`(${query.value})`, 'gi')
  return text.replace(regex, '<mark>$1</mark>')
}
</script>

<style scoped>
.search-view {
  padding: 20px;
}

.search-header {
  text-align: center;
  margin-bottom: 40px;
  padding: 20px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  border-radius: 8px;
}

.search-header h1 {
  font-size: 2rem;
  margin-bottom: 10px;
  color: #333;
}

.search-header p {
  color: #666;
  font-size: 1.1rem;
}

.search-prompt,
.no-results {
  text-align: center;
  padding: 60px 20px;
}

.search-prompt h2,
.no-results h2 {
  font-size: 2rem;
  margin-bottom: 20px;
  color: #333;
}

.search-prompt a,
.no-results a {
  color: #42b883;
  text-decoration: none;
  font-weight: 500;
}

.results-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 30px;
}

.result-card {
  background: white;
  border-radius: 8px;
  padding: 25px;
  box-shadow: 0 4px 6px rgba(0,0,0,0.1);
  transition: transform 0.3s, box-shadow 0.3s;
}

.result-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0,0,0,0.15);
}

.result-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 15px;
}

.result-header h3 {
  margin: 0;
  flex: 1;
}

.result-header h3 a {
  color: #333;
  text-decoration: none;
  font-size: 1.4rem;
  transition: color 0.3s;
}

.result-header h3 a:hover {
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

.excerpt mark {
  background-color: #ffeb3b;
  padding: 0 2px;
  font-weight: bold;
}

.result-meta {
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
  .search-header h1 {
    font-size: 1.5rem;
  }
  
  .results-grid {
    grid-template-columns: 1fr;
  }
  
  .result-header {
    flex-direction: column;
    gap: 10px;
  }
}
</style>