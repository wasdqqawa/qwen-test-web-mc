<template>
  <div class="comments-section">
    <h3>Comments ({{ comments.length }})</h3>
    
    <div class="comment-form">
      <h4>Leave a Comment</h4>
      <form @submit.prevent="submitComment">
        <div class="form-group">
          <input 
            type="text" 
            v-model="newComment.name" 
            placeholder="Your Name" 
            required 
            class="form-input"
          />
        </div>
        
        <div class="form-group">
          <input 
            type="email" 
            v-model="newComment.email" 
            placeholder="Your Email" 
            required 
            class="form-input"
          />
        </div>
        
        <div class="form-group">
          <textarea 
            v-model="newComment.content" 
            placeholder="Your Comment" 
            required 
            rows="4"
            class="form-textarea"
          ></textarea>
        </div>
        
        <button type="submit" class="submit-btn">Post Comment</button>
      </form>
    </div>
    
    <div class="comments-list">
      <div 
        v-for="comment in comments" 
        :key="comment.id" 
        class="comment-item"
      >
        <div class="comment-header">
          <strong>{{ comment.name }}</strong>
          <span class="comment-date">{{ formatDate(comment.date) }}</span>
        </div>
        <p class="comment-content">{{ comment.content }}</p>
        <div class="comment-actions">
          <button @click="replyToComment(comment.id)" class="reply-btn">Reply</button>
          <button @click="likeComment(comment.id)" class="like-btn">
            ❤️ {{ comment.likes }}
          </button>
        </div>
        
        <!-- Reply form if this comment is being replied to -->
        <div v-if="activeReplyId === comment.id" class="reply-form">
          <textarea 
            v-model="replyContent" 
            placeholder="Write your reply..." 
            rows="3"
            class="form-textarea"
          ></textarea>
          <div class="reply-actions">
            <button @click="submitReply(comment.id)" class="submit-btn">Reply</button>
            <button @click="cancelReply" class="cancel-btn">Cancel</button>
          </div>
        </div>
        
        <!-- Replies to this comment -->
        <div v-if="comment.replies && comment.replies.length > 0" class="replies">
          <div 
            v-for="reply in comment.replies" 
            :key="reply.id" 
            class="reply-item"
          >
            <div class="comment-header">
              <strong>{{ reply.name }}</strong>
              <span class="comment-date">{{ formatDate(reply.date) }}</span>
            </div>
            <p class="comment-content">{{ reply.content }}</p>
            <div class="comment-actions">
              <button @click="likeComment(reply.id, 'reply')" class="like-btn">
                ❤️ {{ reply.likes }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Comments',
  props: {
    postId: {
      type: Number,
      required: true
    }
  },
  data() {
    return {
      newComment: {
        name: '',
        email: '',
        content: ''
      },
      replyContent: '',
      activeReplyId: null,
      comments: [
        {
          id: 1,
          name: 'Alice Johnson',
          email: 'alice@example.com',
          content: 'Great article! I really enjoyed learning about Vue.js. The explanations were clear and easy to follow.',
          date: '2025-01-16T10:30:00Z',
          likes: 5,
          replies: [
            {
              id: 101,
              name: 'Jane Doe',
              email: 'jane@example.com',
              content: 'Thank you for your feedback, Alice! I\'m glad you found it helpful.',
              date: '2025-01-16T11:15:00Z',
              likes: 2
            }
          ]
        },
        {
          id: 2,
          name: 'Bob Smith',
          email: 'bob@example.com',
          content: 'I\'ve been using Vue for a while now, and this post covers some advanced concepts that I hadn\'t fully grasped before. Thanks for the insights!',
          date: '2025-01-17T09:45:00Z',
          likes: 3,
          replies: []
        }
      ]
    }
  },
  methods: {
    submitComment() {
      const comment = {
        id: this.comments.length + 1,
        name: this.newComment.name,
        email: this.newComment.email,
        content: this.newComment.content,
        date: new Date().toISOString(),
        likes: 0,
        replies: []
      };
      
      this.comments.push(comment);
      
      // Reset form
      this.newComment = {
        name: '',
        email: '',
        content: ''
      };
    },
    replyToComment(commentId) {
      this.activeReplyId = commentId;
      this.replyContent = '';
    },
    submitReply(commentId) {
      if (!this.replyContent.trim()) return;
      
      const reply = {
        id: Date.now(), // Unique ID for reply
        name: 'Current User', // In a real app, this would come from user session
        email: 'user@example.com',
        content: this.replyContent,
        date: new Date().toISOString(),
        likes: 0
      };
      
      const comment = this.comments.find(c => c.id === commentId);
      if (comment) {
        comment.replies.push(reply);
      }
      
      this.cancelReply();
    },
    cancelReply() {
      this.activeReplyId = null;
      this.replyContent = '';
    },
    likeComment(commentId, type = 'comment') {
      if (type === 'comment') {
        const comment = this.comments.find(c => c.id === commentId);
        if (comment) {
          comment.likes++;
        }
      } else {
        // For replies
        for (let comment of this.comments) {
          const reply = comment.replies.find(r => r.id === commentId);
          if (reply) {
            reply.likes++;
            break;
          }
        }
      }
    },
    formatDate(dateString) {
      const date = new Date(dateString);
      return date.toLocaleDateString(undefined, {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
      });
    }
  }
}
</script>

<style scoped>
.comments-section {
  margin-top: 2rem;
  padding-top: 2rem;
  border-top: 1px solid #e9ecef;
}

.comments-section h3 {
  color: #333;
  margin-bottom: 1.5rem;
}

.comment-form {
  background: #f8f9fa;
  padding: 1.5rem;
  border-radius: 8px;
  margin-bottom: 2rem;
}

.comment-form h4 {
  margin-top: 0;
  margin-bottom: 1rem;
  color: #333;
}

.form-group {
  margin-bottom: 1rem;
}

.form-input, .form-textarea {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid #ced4da;
  border-radius: 4px;
  font-size: 1rem;
  transition: border-color 0.3s ease;
}

.form-input:focus, .form-textarea:focus {
  outline: none;
  border-color: #667eea;
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.form-textarea {
  resize: vertical;
}

.submit-btn {
  background: #667eea;
  color: white;
  border: none;
  padding: 0.75rem 1.5rem;
  border-radius: 4px;
  font-size: 1rem;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.submit-btn:hover {
  background: #5a6fd8;
}

.comments-list {
  margin-top: 1.5rem;
}

.comment-item {
  background: white;
  border-radius: 8px;
  padding: 1.5rem;
  margin-bottom: 1rem;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.comment-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.5rem;
}

.comment-date {
  color: #868e96;
  font-size: 0.8rem;
}

.comment-content {
  margin: 0.5rem 0 1rem;
  color: #495057;
  line-height: 1.6;
}

.comment-actions {
  display: flex;
  gap: 1rem;
}

.reply-btn, .like-btn {
  background: none;
  border: none;
  color: #667eea;
  cursor: pointer;
  font-size: 0.9rem;
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
  transition: background-color 0.2s ease;
}

.reply-btn:hover, .like-btn:hover {
  background: #f8f9fa;
}

.reply-form {
  margin-top: 1rem;
  padding-top: 1rem;
  border-top: 1px solid #e9ecef;
}

.reply-actions {
  margin-top: 0.5rem;
  display: flex;
  gap: 0.5rem;
}

.cancel-btn {
  background: #e9ecef;
  color: #495057;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.9rem;
}

.cancel-btn:hover {
  background: #dee2e6;
}

.replies {
  margin-top: 1rem;
  padding-left: 1.5rem;
  border-left: 2px solid #e9ecef;
}

.reply-item {
  background: #f8f9fa;
  border-radius: 8px;
  padding: 1rem;
  margin-bottom: 0.75rem;
}
</style>