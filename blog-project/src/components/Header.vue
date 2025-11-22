<template>
  <header class="header">
    <div class="header-content">
      <div class="logo">
        <h1>
          <router-link to="/">My Blog</router-link>
        </h1>
      </div>
      <nav class="nav">
        <ul>
          <li><router-link to="/">Home</router-link></li>
          <li><router-link to="/categories">Categories</router-link></li>
          <li><router-link to="/about">About</router-link></li>
        </ul>
        <form @submit.prevent="search" class="search-form">
          <input 
            type="text" 
            v-model="searchQuery" 
            placeholder="Search articles..."
            class="search-input"
          />
          <button type="submit">Search</button>
        </form>
      </nav>
    </div>
  </header>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const searchQuery = ref('')

const search = () => {
  if (searchQuery.value.trim()) {
    router.push({ name: 'search', query: { q: searchQuery.value } })
  }
}
</script>

<style scoped>
.header {
  background-color: #fff;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  position: sticky;
  top: 0;
  z-index: 100;
}

.header-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
}

.logo h1 {
  margin: 0;
}

.logo a {
  text-decoration: none;
  color: #333;
  font-size: 1.8rem;
}

.nav {
  display: flex;
  align-items: center;
  gap: 20px;
}

.nav ul {
  display: flex;
  list-style: none;
  margin: 0;
  padding: 0;
  gap: 20px;
}

.nav a {
  text-decoration: none;
  color: #666;
  font-weight: 500;
  transition: color 0.3s;
}

.nav a.router-link-active,
.nav a:hover {
  color: #42b883;
}

.search-form {
  display: flex;
  gap: 5px;
  margin-left: 20px;
}

.search-input {
  padding: 5px 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
  width: 200px;
}

.search-input:focus {
  outline: none;
  border-color: #42b883;
}

@media (max-width: 768px) {
  .header-content {
    flex-direction: column;
    gap: 15px;
    padding: 10px;
  }
  
  .nav {
    width: 100%;
    justify-content: space-between;
  }
  
  .nav ul {
    gap: 10px;
  }
  
  .search-form {
    width: 100%;
    margin-left: 0;
    justify-content: center;
  }
  
  .search-input {
    width: 100%;
  }
}
</style>