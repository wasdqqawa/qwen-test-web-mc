<template>
  <div class="about">
    <section class="hero">
      <h1>About This Blog</h1>
      <p>Learn more about our mission and values</p>
    </section>

    <section class="content">
      <div class="about-section">
        <h2>Our Story</h2>
        <p>This blog was created to share knowledge, experiences, and insights about web development, technology, and the digital world. We believe in the power of sharing knowledge and helping others learn and grow.</p>
        
        <p>Founded in 2025, our mission is to provide high-quality, accessible content that helps developers of all levels improve their skills and stay up-to-date with the latest trends in technology.</p>
      </div>

      <div class="about-section">
        <h2>What We Do</h2>
        <p>We create comprehensive tutorials, in-depth articles, and practical guides on various topics including:</p>
        <ul>
          <li>Frontend frameworks (Vue.js, React, Angular)</li>
          <li>Backend technologies and APIs</li>
          <li>Web performance optimization</li>
          <li>Modern development tools and practices</li>
          <li>UI/UX design principles</li>
        </ul>
      </div>

      <div class="about-section">
        <h2>Our Team</h2>
        <div class="team-grid">
          <div class="team-member">
            <div class="avatar">JD</div>
            <h3>Jane Doe</h3>
            <p>Senior Frontend Developer</p>
          </div>
          <div class="team-member">
            <div class="avatar">JS</div>
            <h3>John Smith</h3>
            <p>Full Stack Engineer</p>
          </div>
          <div class="team-member">
            <div class="avatar">AJ</div>
            <h3>Alex Johnson</h3>
            <p>Tech Writer & Editor</p>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
export default {
  name: 'About'
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

.content {
  max-width: 800px;
  margin: 0 auto;
}

.about-section {
  margin-bottom: 3rem;
  padding: 1.5rem;
  background: white;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.about-section h2 {
  margin-top: 0;
  color: #333;
  font-size: 1.8rem;
  margin-bottom: 1rem;
}

.about-section p {
  line-height: 1.6;
  color: #495057;
  margin-bottom: 1rem;
}

.about-section ul {
  padding-left: 1.5rem;
  color: #495057;
  line-height: 1.8;
}

.team-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1.5rem;
  margin-top: 1.5rem;
}

.team-member {
  text-align: center;
}

.avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 1.5rem;
  font-weight: bold;
  margin: 0 auto 1rem;
}

.team-member h3 {
  margin: 0.5rem 0;
  color: #333;
}

.team-member p {
  color: #6c757d;
  margin: 0;
}

@media (max-width: 768px) {
  .hero h1 {
    font-size: 2rem;
  }
  
  .about-section {
    padding: 1rem;
  }
}
</style>