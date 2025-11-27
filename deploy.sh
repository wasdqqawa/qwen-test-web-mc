#!/bin/bash

# Minecraft Clone Unity WebGL 部署脚本

echo "开始部署 Minecraft Clone Unity WebGL 项目..."

# 创建构建目录
mkdir -p Build/WebGL

# 创建一个模拟的UnityLoader.js文件（实际项目中需要通过Unity构建生成）
cat > Build/WebGL/UnityLoader.js << 'EOF'
// Unity WebGL Player Loader
// 这是一个模拟文件，实际项目中需要通过Unity构建生成

var unityInstance = null;

function createUnityInstance(canvas, unityArgs, onProgress) {
  // 模拟Unity实例创建
  console.log("Unity WebGL Player initialized");
  
  // 模拟加载进度
  if (onProgress) {
    let progress = 0;
    const interval = setInterval(() => {
      progress += 5;
      onProgress({loaded: progress, total: 100});
      if (progress >= 100) {
        clearInterval(interval);
        console.log("Unity WebGL Player loaded successfully");
      }
    }, 100);
  }
  
  unityInstance = {
    Module: {},
    SendMessage: function(gameObject, method, message) {
      console.log("SendMessage:", gameObject, method, message);
      // 将Unity消息转发到全局变量
      if (window.unityInstance) {
        window.unityInstance.SendMessage(gameObject, method, message);
      }
    },
    SetFullscreen: function() {
      console.log("Fullscreen mode set");
    }
  };
  
  // 将实例赋值给全局变量
  window.unityInstance = unityInstance;
  
  return unityInstance;
}
EOF

# 创建WebGL构建文件
cat > Build/WebGL/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minecraft-Style 3D WebGL Game</title>
    <script src="https://simplewebrtc.com/latest-v3.js"></script>
    <style>
        body { 
            margin: 0; 
            padding: 0; 
            overflow: hidden; 
            background: #000; 
            font-family: Arial, sans-serif;
        }
        #gameContainer { 
            position: absolute; 
            top: 0; 
            left: 0; 
            width: 100%; 
            height: 100%; 
        }
        #loadingScreen {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: #000;
            color: #fff;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            z-index: 100;
        }
        #loadingScreen h1 {
            font-size: 2em;
            margin-bottom: 20px;
        }
        #progressBar {
            width: 80%;
            height: 20px;
            background: #333;
            border-radius: 10px;
            overflow: hidden;
        }
        #progress {
            height: 100%;
            width: 0%;
            background: #4CAF50;
            transition: width 0.3s;
        }
        #instructions {
            position: absolute;
            bottom: 20px;
            left: 20px;
            color: white;
            background: rgba(0,0,0,0.5);
            padding: 10px;
            border-radius: 5px;
            font-size: 14px;
            max-width: 400px;
        }
    </style>
</head>
<body>
    <div id="gameContainer">
        <div id="loadingScreen">
            <h1>Minecraft-Style WebGL Game</h1>
            <div id="progressBar">
                <div id="progress"></div>
            </div>
            <p>Loading game...</p>
        </div>
        
        <!-- Network Connection Panel -->
        <div id="connectionPanel" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: rgba(0,0,0,0.8); color: white; padding: 30px; border-radius: 10px; z-index: 200; display: block;">
            <h2 style="text-align: center; margin-top: 0;">Multiplayer Connection</h2>
            <div style="display: flex; flex-direction: column; align-items: center;">
                <button id="hostButton" style="padding: 10px 20px; margin: 10px; background: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px;">Host Game</button>
                <div style="display: flex; align-items: center; margin: 10px;">
                    <input type="text" id="roomIdInput" placeholder="Enter Room ID" style="padding: 10px; margin-right: 10px; border-radius: 5px; border: none; width: 200px;">
                    <button id="joinButton" style="padding: 10px 20px; background: #2196F3; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px;">Join Game</button>
                </div>
                <div id="connectionStatus" style="margin-top: 15px; text-align: center;">Not Connected</div>
                <div id="playerCount" style="margin-top: 5px; text-align: center;">Players: 0</div>
            </div>
        </div>
        
        <canvas id="gameCanvas" width="1200" height="700"></canvas>
    </div>
    
    <div id="instructions">
        <strong>Controls:</strong><br>
        WASD/Arrow Keys: Move<br>
        Mouse: Look around<br>
        Space: Jump<br>
        Left Click: Remove block<br>
        Right Click: Place block
    </div>

    <script src="UnityLoader.js"></script>
    <script>
        var buildUrl = "Build";
        var loaderUrl = buildUrl + "/MinecraftClone.json";
        var moduleUrl = buildUrl + "/MinecraftClone.wasm";
        var dataUrl = buildUrl + "/MinecraftClone.data";
        
        // 模拟Unity WebGL加载过程
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(function() {
                const loadingScreen = document.getElementById('loadingScreen');
                const progressBar = document.getElementById('progressBar');
                const progress = document.getElementById('progress');
                
                let width = 0;
                const interval = setInterval(function() {
                    if (width >= 100) {
                        clearInterval(interval);
                        loadingScreen.style.display = 'none';
                    } else {
                        width++; 
                        progress.style.width = width + '%';
                    }
                }, 30);
            }, 1000);
        });
        
        // WebRTC Network Functions
        let webRTCManager = null;
        
        // 初始化WebRTC
        function initWebRTC() {
            if (typeof SimpleWebRTC !== 'undefined') {
                webRTCManager = new SimpleWebRTC({
                    localVideoEl: 'localVideo',
                    remoteVideosEl: 'remoteVideos',
                    autoRequestMedia: false,
                    connection: new RTCMultiConnection(),
                });
                
                // 配置连接
                webRTCManager.connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';
                webRTCManager.connection.session = {
                    data: true, // 启用数据通道
                    audio: false, // 不需要音频
                    video: false  // 不需要视频
                };
                
                // 监听数据消息
                webRTCManager.connection.onmessage = function(event) {
                    // 将接收到的消息传递给Unity
                    if (window.unityInstance) {
                        window.unityInstance.SendMessage('WebRTCNetworkManager', 'OnWebRTCMessage', event.data);
                    }
                };
                
                console.log("WebRTC Initialized");
                return true;
            }
            console.error("SimpleWebRTC not loaded");
            return false;
        }
        
        // 创建房间（作为主机）
        function createRoom() {
            if (!webRTCManager) {
                console.error("WebRTC not initialized");
                return false;
            }
            
            const roomId = "mc_" + Date.now().toString();
            webRTCManager.createRoom(roomId, function(roomId) {
                console.log("Created room: " + roomId);
                document.getElementById('connectionStatus').textContent = "Hosting Game: " + roomId;
                document.getElementById('roomIdInput').value = roomId;
                document.getElementById('connectionPanel').style.display = 'none';
            });
            
            return true;
        }
        
        // 加入房间
        function joinRoom(roomId) {
            if (!webRTCManager) {
                console.error("WebRTC not initialized");
                return false;
            }
            
            webRTCManager.joinRoom(roomId, function() {
                console.log("Joined room: " + roomId);
                document.getElementById('connectionStatus').textContent = "Joined Game: " + roomId;
                document.getElementById('connectionPanel').style.display = 'none';
            });
            
            return true;
        }
        
        // 发送数据消息
        function sendWebRTCMessage(message) {
            if (!webRTCManager) {
                console.error("WebRTC not initialized");
                return false;
            }
            
            webRTCManager.connection.send(message);
            return true;
        }
        
        // 检查连接状态
        function isWebRTCConnected() {
            if (!webRTCManager) {
                return false;
            }
            
            return webRTCManager.connection.isInitiator || 
                   webRTCManager.getPeers().length > 0;
        }
        
        // 获取对等方数量
        function getPeerCount() {
            if (!webRTCManager) {
                return 0;
            }
            
            return webRTCManager.getPeers().length;
        }
        
        // 设置按钮事件
        document.getElementById('hostButton').addEventListener('click', function() {
            if (initWebRTC()) {
                createRoom();
            } else {
                alert("Failed to initialize WebRTC. Please check your browser supports it.");
            }
        });
        
        document.getElementById('joinButton').addEventListener('click', function() {
            const roomId = document.getElementById('roomIdInput').value.trim();
            if (roomId) {
                if (initWebRTC()) {
                    joinRoom(roomId);
                } else {
                    alert("Failed to initialize WebRTC. Please check your browser supports it.");
                }
            } else {
                alert("Please enter a Room ID");
            }
        });
        
        // 定期更新玩家数量
        setInterval(function() {
            if (webRTCManager && isWebRTCConnected()) {
                const peerCount = getPeerCount();
                document.getElementById('playerCount').textContent = "Players: " + (peerCount + 1); // +1 for local player
            }
        }, 1000);
    </script>
</body>
</html>
EOF

# 创建一个简单的构建说明
cat > Build/WebGL/README.txt << 'EOF'
Unity WebGL Build Files

This directory contains the files for the Minecraft-Style WebGL game with multiplayer support.

To build the complete project:
1. Open the project in Unity
2. Go to File > Build Settings
3. Select WebGL platform
4. Click Build and replace files in this Build/WebGL folder

The build should include:
- UnityLoader.js
- MinecraftClone.json (or your project name)
- MinecraftClone.wasm
- MinecraftClone.data

The project includes:
- Procedural world generation
- Block placement/removal
- Multiplayer support via WebRTC
- Network synchronization
EOF

echo "部署脚本执行完成！"
echo ""
echo "要运行完整项目，请："
echo "1. 在Unity中打开此项目"
echo "2. 构建WebGL版本到Build/WebGL目录"
echo "3. 使用Web服务器托管整个目录"
echo ""
echo "注意：当前版本包含模拟的Unity文件，需要通过Unity编辑器构建才能获得完整功能。"
echo "WebRTC多人游戏功能已集成，支持P2P连接。"