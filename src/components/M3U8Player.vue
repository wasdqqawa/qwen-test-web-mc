<template>
  <div class="player-container">
    <h2>M3U8播放器</h2>
    
    <div class="input-section">
      <input 
        v-model="streamUrl" 
        type="text" 
        placeholder="请输入M3U8直播流地址，例如: https://example.com/playlist.m3u8"
        class="url-input"
        @keyup.enter="loadStream"
      />
      <button @click="loadStream" class="load-btn" :disabled="isLoading">加载流</button>
      <button @click="toggleFullscreen" class="fullscreen-btn" v-if="streamUrl">
        {{ isFullscreen ? '退出全屏' : '全屏' }}
      </button>
    </div>
    
    <div class="player-controls" v-if="streamUrl">
      <div class="quality-selector" v-if="availableQualities.length > 0">
        <label>画质:</label>
        <select @change="changeQuality" v-model="selectedQuality">
          <option 
            v-for="quality in availableQualities" 
            :key="quality.level" 
            :value="quality.level"
          >
            {{ quality.name }}
          </option>
        </select>
      </div>
      
      <div class="playback-controls">
        <button @click="togglePlayPause" class="control-btn">
          {{ isPlaying ? '暂停' : '播放' }}
        </button>
        <button @click="toggleMute" class="control-btn">
          {{ isMuted ? '取消静音' : '静音' }}
        </button>
        <div class="volume-control">
          <label>音量:</label>
          <input 
            type="range" 
            min="0" 
            max="1" 
            step="0.01" 
            v-model="volume" 
            @input="changeVolume"
            class="volume-slider"
          />
        </div>
      </div>
    </div>
    
    <div class="player-wrapper" v-if="streamUrl">
      <video 
        ref="videoRef" 
        class="video-player" 
        playsinline
        :poster="defaultPoster"
        @timeupdate="onTimeUpdate"
        @play="onPlay"
        @pause="onPause"
        @volumechange="onVolumeChange"
      >
        您的浏览器不支持视频播放
      </video>
      
      <div class="player-status" v-if="statusMessage">
        <p>{{ statusMessage }}</p>
      </div>
    </div>
    
    <div class="presets-section">
      <h3>预设流地址</h3>
      <div class="preset-buttons">
        <button 
          v-for="preset in presets" 
          :key="preset.name"
          @click="loadPreset(preset.url)"
          class="preset-btn"
          :disabled="isLoading"
        >
          {{ preset.name }}
        </button>
      </div>
    </div>
    
    <div class="history-section">
      <h3>播放历史</h3>
      <div class="history-list">
        <div 
          v-for="(item, index) in playbackHistory" 
          :key="index"
          class="history-item"
          @click="loadFromHistory(item)"
        >
          {{ item.name || item.url }}
          <span class="history-url">{{ item.url }}</span>
        </div>
        <p v-if="playbackHistory.length === 0" class="no-history">暂无播放历史</p>
      </div>
      <button @click="clearHistory" class="clear-history-btn" v-if="playbackHistory.length > 0">
        清空历史
      </button>
    </div>
    
    <div class="instructions">
      <h3>使用说明</h3>
      <ul>
        <li>输入有效的M3U8直播流地址</li>
        <li>点击"加载流"按钮开始播放</li>
        <li>点击预设按钮可快速加载常用流</li>
        <li>支持大部分HLS格式的直播流</li>
        <li>可切换画质、静音、调节音量</li>
      </ul>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import Hls from 'hls.js';

// 响应式数据
const streamUrl = ref('');
const videoRef = ref(null);
const isLoading = ref(false);
const statusMessage = ref('');
const isPlaying = ref(false);
const isMuted = ref(false);
const volume = ref(1);
const isFullscreen = ref(false);
const selectedQuality = ref(-1); // -1 表示自动
const availableQualities = ref([]);

let hls = null;

// 播放历史
const playbackHistory = ref(JSON.parse(localStorage.getItem('playbackHistory') || '[]'));

// 预设流地址
const presets = ref([
  { name: '测试流1', url: 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8' },
  { name: 'Apple测试流', url: 'https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8' },
  { name: 'Apple测试流2', url: 'https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8' },
  { name: 'Big Buck Bunny', url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/AppleAndOranges.m3u8' },
  { name: '法国新闻', url: 'https://www.futhq.com/streams/636/index.m3u8' }
]);

// 默认海报图片
const defaultPoster = 'https://via.placeholder.com/800x450/3498db/ffffff?text=在线M3U8播放器';

// 添加到播放历史
const addToHistory = (url, name = null) => {
  const existingIndex = playbackHistory.value.findIndex(item => item.url === url);
  if (existingIndex !== -1) {
    playbackHistory.value.splice(existingIndex, 1);
  }
  
  playbackHistory.value.unshift({
    url,
    name: name || url.substring(0, 50) + (url.length > 50 ? '...' : ''),
    timestamp: new Date().toISOString()
  });
  
  // 限制历史记录数量
  if (playbackHistory.value.length > 10) {
    playbackHistory.value = playbackHistory.value.slice(0, 10);
  }
  
  localStorage.setItem('playbackHistory', JSON.stringify(playbackHistory.value));
};

// 从历史记录加载
const loadFromHistory = (item) => {
  streamUrl.value = item.url;
  loadVideo(item.url);
};

// 清空历史记录
const clearHistory = () => {
  playbackHistory.value = [];
  localStorage.removeItem('playbackHistory');
};

const loadStream = () => {
  if (!streamUrl.value) {
    alert('请输入M3U8流地址');
    return;
  }
  
  // 添加到历史记录
  addToHistory(streamUrl.value);
  
  loadVideo(streamUrl.value);
};

const loadPreset = (url) => {
  streamUrl.value = url;
  addToHistory(url, presets.value.find(p => p.url === url)?.name);
  loadVideo(url);
};

const loadVideo = (url) => {
  // 设置加载状态
  isLoading.value = true;
  statusMessage.value = '正在加载视频流...';
  
  // 销毁之前的播放器实例
  if (hls) {
    hls.destroy();
  }
  
  const video = videoRef.value;
  if (!video) return;
  
  // 重置状态
  availableQualities.value = [];
  selectedQuality.value = -1;
  
  if (video.canPlayType('application/vnd.apple.mpegurl')) {
    // Safari原生支持HLS
    video.src = url;
    video.play().catch(error => {
      console.error('播放失败:', error);
      statusMessage.value = '自动播放失败，请手动点击播放按钮';
    });
  } else if (Hls.isSupported()) {
    // 使用hls.js
    hls = new Hls({
      enableWorker: true,
      lowLatencyMode: true,
      backBufferLength: 90,
    });
    hls.loadSource(url);
    hls.attachMedia(video);
    
    hls.on(Hls.Events.MANIFEST_PARSED, () => {
      statusMessage.value = '视频流加载成功，正在播放...';
      video.play().catch(error => {
        console.error('播放失败:', error);
        statusMessage.value = '自动播放失败，请手动点击播放按钮';
      });
    });
    
    // 获取可用画质
    hls.on(Hls.Events.MANIFEST_LOADED, (event, data) => {
      if (data.levels && data.levels.length > 0) {
        availableQualities.value = data.levels.map((level, index) => ({
          level: index,
          name: `${level.height}p (${Math.round(level.bitrate / 1000)}kbps)`
        }));
        availableQualities.value.unshift({ level: -1, name: '自动' }); // 添加自动选项
      }
    });
    
    hls.on(Hls.Events.ERROR, (event, data) => {
      console.error('HLS错误:', event, data);
      if (data.fatal) {
        switch(data.type) {
          case Hls.ErrorTypes.NETWORK_ERROR:
            statusMessage.value = '网络错误，正在尝试重连...';
            hls.startLoad();
            break;
          case Hls.ErrorTypes.MEDIA_ERROR:
            statusMessage.value = '媒体错误，正在尝试恢复...';
            hls.recoverMediaError();
            break;
          default:
            console.error('未知错误类型:', data.type);
            statusMessage.value = '播放出错，请检查流地址是否有效';
            break;
        }
      }
    });
  } else {
    statusMessage.value = '您的浏览器不支持HLS播放，请尝试使用Chrome、Firefox或Edge浏览器';
  }
  
  // 重置加载状态
  setTimeout(() => {
    isLoading.value = false;
  }, 2000);
};

// 切换播放/暂停
const togglePlayPause = () => {
  const video = videoRef.value;
  if (video) {
    if (video.paused) {
      video.play();
    } else {
      video.pause();
    }
  }
};

// 切换静音
const toggleMute = () => {
  const video = videoRef.value;
  if (video) {
    video.muted = !video.muted;
    isMuted.value = video.muted;
  }
};

// 改变音量
const changeVolume = () => {
  const video = videoRef.value;
  if (video) {
    video.volume = parseFloat(volume.value);
  }
};

// 全屏切换
const toggleFullscreen = () => {
  const video = videoRef.value;
  if (!video) return;
  
  if (!document.fullscreenElement) {
    if (video.requestFullscreen) {
      video.requestFullscreen();
    } else if (video.mozRequestFullScreen) { /* Firefox */
      video.mozRequestFullScreen();
    } else if (video.webkitRequestFullscreen) { /* Chrome, Safari & Opera */
      video.webkitRequestFullscreen();
    } else if (video.msRequestFullscreen) { /* IE/Edge */
      video.msRequestFullscreen();
    }
    isFullscreen.value = true;
  } else {
    if (document.exitFullscreen) {
      document.exitFullscreen();
    } else if (document.mozCancelFullScreen) { /* Firefox */
      document.mozCancelFullScreen();
    } else if (document.webkitExitFullscreen) { /* Chrome, Safari & Opera */
      document.webkitExitFullscreen();
    } else if (document.msExitFullscreen) { /* IE/Edge */
      document.msExitFullscreen();
    }
    isFullscreen.value = false;
  }
};

// 改变画质
const changeQuality = () => {
  if (hls) {
    hls.nextLevel = selectedQuality.value;
  }
};

// 事件处理
const onPlay = () => {
  isPlaying.value = true;
};

const onPause = () => {
  isPlaying.value = false;
};

const onVolumeChange = () => {
  const video = videoRef.value;
  if (video) {
    isMuted.value = video.muted;
    volume.value = video.volume;
  }
};

const onTimeUpdate = () => {
  // 可以在这里添加进度更新逻辑
};

onUnmounted(() => {
  if (hls) {
    hls.destroy();
  }
  
  // 退出全屏
  if (document.fullscreenElement) {
    document.exitFullscreen();
  }
});

// 监听全屏变化事件
const handleFullscreenChange = () => {
  isFullscreen.value = !!document.fullscreenElement;
};

onMounted(() => {
  document.addEventListener('fullscreenchange', handleFullscreenChange);
  document.addEventListener('webkitfullscreenchange', handleFullscreenChange);
  document.addEventListener('mozfullscreenchange', handleFullscreenChange);
  document.addEventListener('MSFullscreenChange', handleFullscreenChange);
});

onUnmounted(() => {
  document.removeEventListener('fullscreenchange', handleFullscreenChange);
  document.removeEventListener('webkitfullscreenchange', handleFullscreenChange);
  document.removeEventListener('mozfullscreenchange', handleFullscreenChange);
  document.removeEventListener('MSFullscreenChange', handleFullscreenChange);
  
  if (hls) {
    hls.destroy();
  }
});
</script>

<style scoped>
.player-container {
  max-width: 1000px;
  margin: 0 auto;
  padding: 20px;
}

.player-container h2 {
  text-align: center;
  color: #333;
  margin-bottom: 20px;
}

.input-section {
  display: flex;
  gap: 10px;
  margin-bottom: 30px;
  flex-wrap: wrap;
  align-items: center;
}

.url-input {
  flex: 1;
  padding: 12px;
  border: 2px solid #ddd;
  border-radius: 6px;
  font-size: 16px;
  min-width: 300px;
}

.load-btn {
  padding: 12px 24px;
  background: #3498db;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 16px;
  transition: background 0.3s;
}

.load-btn:hover:not(:disabled) {
  background: #2980b9;
}

.load-btn:disabled {
  background: #bdc3c7;
  cursor: not-allowed;
}

.fullscreen-btn {
  padding: 12px 16px;
  background: #9b59b6;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 16px;
  transition: background 0.3s;
}

.fullscreen-btn:hover {
  background: #8e44ad;
}

.player-controls {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  margin-bottom: 20px;
  padding: 15px;
  background: #f8f9fa;
  border-radius: 8px;
  align-items: center;
}

.quality-selector {
  display: flex;
  align-items: center;
  gap: 10px;
}

.quality-selector label {
  font-weight: bold;
  color: #333;
}

.quality-selector select {
  padding: 8px;
  border: 1px solid #ddd;
  border-radius: 4px;
  background: white;
}

.playback-controls {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  align-items: center;
}

.control-btn {
  padding: 8px 16px;
  background: #e74c3c;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background 0.3s;
}

.control-btn:hover {
  background: #c0392b;
}

.volume-control {
  display: flex;
  align-items: center;
  gap: 8px;
}

.volume-control label {
  font-weight: bold;
  color: #333;
}

.volume-slider {
  width: 100px;
}

.player-wrapper {
  margin: 20px 0;
  text-align: center;
  position: relative;
}

.video-player {
  width: 100%;
  max-width: 800px;
  height: auto;
  border-radius: 8px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
  background: #000;
}

.player-status {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: rgba(0, 0, 0, 0.7);
  color: white;
  padding: 10px 20px;
  border-radius: 4px;
  font-size: 16px;
  z-index: 10;
}

.presets-section {
  margin: 30px 0;
}

.presets-section h3 {
  margin-bottom: 15px;
  color: #333;
}

.preset-buttons {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  justify-content: center;
}

.preset-btn {
  padding: 10px 15px;
  background: #2ecc71;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background 0.3s;
  white-space: nowrap;
}

.preset-btn:hover:not(:disabled) {
  background: #27ae60;
}

.preset-btn:disabled {
  background: #bdc3c7;
  cursor: not-allowed;
}

.history-section {
  margin: 30px 0;
  padding: 20px;
  background: #f8f9fa;
  border-radius: 8px;
}

.history-section h3 {
  margin-bottom: 15px;
  color: #333;
}

.history-list {
  max-height: 200px;
  overflow-y: auto;
  margin-bottom: 15px;
}

.history-item {
  padding: 10px;
  background: white;
  border: 1px solid #ddd;
  border-radius: 4px;
  margin-bottom: 8px;
  cursor: pointer;
  transition: background 0.3s;
}

.history-item:hover {
  background: #e9ecef;
}

.history-url {
  display: block;
  font-size: 0.9em;
  color: #6c757d;
  margin-top: 4px;
}

.no-history {
  text-align: center;
  color: #6c757d;
  font-style: italic;
}

.clear-history-btn {
  padding: 8px 16px;
  background: #e74c3c;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background 0.3s;
}

.clear-history-btn:hover {
  background: #c0392b;
}

.instructions {
  margin-top: 30px;
  padding: 20px;
  background: #f8f9fa;
  border-radius: 8px;
}

.instructions h3 {
  color: #333;
  margin-bottom: 10px;
}

.instructions ul {
  padding-left: 20px;
}

.instructions li {
  margin: 8px 0;
  color: #555;
}

@media (max-width: 768px) {
  .input-section {
    flex-direction: column;
    align-items: stretch;
  }
  
  .url-input {
    min-width: 100%;
  }
  
  .player-controls {
    flex-direction: column;
    align-items: stretch;
  }
  
  .quality-selector, .playback-controls {
    justify-content: center;
  }
  
  .volume-slider {
    width: 150px;
  }
  
  .preset-buttons {
    flex-direction: column;
    align-items: center;
  }
  
  .preset-btn {
    width: 100%;
    max-width: 300px;
  }
  
  .history-item {
    text-align: left;
  }
}
</style>