<template>
  <div class="article-detail" v-if="article">
    <article class="article-content">
      <header class="article-header">
        <h1>{{ article.title }}</h1>
        <div class="article-meta">
          <span class="author">By {{ article.author }}</span>
          <span class="date">{{ formatDate(article.date) }}</span>
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
      </header>
      
      <div class="article-body">
        <div v-html="renderMarkdown(article.content)" class="content"></div>
      </div>
    </article>
    
    <aside class="sidebar">
      <div class="related-articles">
        <h3>Related Articles</h3>
        <ul>
          <li 
            v-for="related in relatedArticles" 
            :key="related.id"
          >
            <router-link 
              :to="{ name: 'article', params: { id: related.id } }"
            >
              {{ related.title }}
            </router-link>
          </li>
        </ul>
      </div>
    </aside>
  </div>
  
  <div v-else class="not-found">
    <h2>Article not found</h2>
    <p>The article you're looking for doesn't exist.</p>
    <router-link to="/">Back to Home</router-link>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import { marked } from 'marked'
import { useBlogStore } from '../stores/blog'

const route = useRoute()
const blogStore = useBlogStore()

const article = computed(() => {
  return blogStore.getArticleById(route.params.id)
})

const relatedArticles = computed(() => {
  if (!article.value) return []
  return blogStore.articles
    .filter(a => a.id !== article.value.id && a.category === article.value.category)
    .slice(0, 3)
})

const formatDate = (dateString) => {
  const options = { year: 'numeric', month: 'long', day: 'numeric' }
  return new Date(dateString).toLocaleDateString(undefined, options)
}

const renderMarkdown = (content) => {
  return marked.parse(content)
}
</script>

<style scoped>
.article-detail {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 40px;
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.article-content {
  background: white;
  border-radius: 8px;
  padding: 40px;
  box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

.article-header h1 {
  font-size: 2.2rem;
  margin-bottom: 20px;
  color: #333;
  line-height: 1.3;
}

.article-meta {
  display: flex;
  gap: 20px;
  margin-bottom: 20px;
  padding-bottom: 15px;
  border-bottom: 1px solid #eee;
  font-size: 0.9rem;
  color: #666;
}

.author, .date {
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
  margin-bottom: 20px;
}

.tag {
  background-color: #eef7f0;
  color: #42b883;
  padding: 4px 10px;
  border-radius: 20px;
  font-size: 0.8rem;
}

.article-body {
  margin-top: 30px;
}

.content {
  line-height: 1.8;
}

.content h1,
.content h2,
.content h3 {
  margin: 1.5em 0 1em 0;
  color: #333;
}

.content h1 {
  font-size: 1.8rem;
}

.content h2 {
  font-size: 1.5rem;
}

.content h3 {
  font-size: 1.3rem;
}

.content p {
  margin-bottom: 1em;
}

.content ul,
.content ol {
  margin: 1em 0;
  padding-left: 1.5em;
}

.content li {
  margin-bottom: 0.5em;
}

.content code {
  background-color: #f4f4f4;
  padding: 2px 6px;
  border-radius: 3px;
  font-family: monospace;
}

.content pre {
  background-color: #f4f4f4;
  padding: 15px;
  border-radius: 5px;
  overflow-x: auto;
  margin: 1.5em 0;
}

.sidebar {
  background: white;
  border-radius: 8px;
  padding: 25px;
  box-shadow: 0 4px 6px rgba(0,0,0,0.1);
  align-self: start;
  position: sticky;
  top: 100px;
}

.sidebar h3 {
  margin-top: 0;
  margin-bottom: 15px;
  color: #333;
  font-size: 1.3rem;
}

.related-articles ul {
  list-style: none;
  padding: 0;
}

.related-articles li {
  margin-bottom: 15px;
  padding-bottom: 10px;
  border-bottom: 1px solid #eee;
}

.related-articles a {
  text-decoration: none;
  color: #42b883;
  display: block;
  transition: color 0.3s;
}

.related-articles a:hover {
  color: #35495e;
}

.not-found {
  text-align: center;
  padding: 60px 20px;
}

.not-found h2 {
  font-size: 2rem;
  margin-bottom: 20px;
  color: #333;
}

.not-found a {
  color: #42b883;
  text-decoration: none;
  font-weight: 500;
}

@media (max-width: 768px) {
  .article-detail {
    grid-template-columns: 1fr;
    gap: 20px;
    padding: 10px;
  }
  
  .article-content {
    padding: 25px;
  }
  
  .sidebar {
    position: static;
  }
}
</style>