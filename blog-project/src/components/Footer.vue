<template>
  <footer class="footer">
    <div class="footer-content">
      <div class="footer-section">
        <h3>My Blog</h3>
        <p>A place for thoughts, ideas, and stories.</p>
      </div>
      <div class="footer-section">
        <h4>Quick Links</h4>
        <ul>
          <li><router-link to="/">Home</router-link></li>
          <li><router-link to="/categories">Categories</router-link></li>
          <li><router-link to="/about">About</router-link></li>
        </ul>
      </div>
      <div class="footer-section">
        <h4>Connect</h4>
        <p>Email: contact@myblog.com</p>
      </div>
    </div>
    <div class="footer-bottom">
      <p>&copy; {{ new Date().getFullYear() }} My Blog. All rights reserved.</p>
    </div>
  </footer>
</template>

<script setup>
</script>

<style scoped>
.footer {
  background-color: #333;
  color: white;
  margin-top: auto;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 20px 20px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
}

.footer-section h3,
.footer-section h4 {
  margin-bottom: 15px;
  color: #42b883;
}

.footer-section ul {
  list-style: none;
  padding: 0;
}

.footer-section ul li {
  margin-bottom: 8px;
}

.footer-section a {
  color: #ddd;
  text-decoration: none;
  transition: color 0.3s;
}

.footer-section a:hover {
  color: #42b883;
}

.footer-bottom {
  border-top: 1px solid #555;
  padding: 20px;
  text-align: center;
  color: #aaa;
}
</style>