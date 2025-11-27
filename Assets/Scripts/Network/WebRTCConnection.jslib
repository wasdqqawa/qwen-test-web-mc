mergeInto(LibraryManager.library, {
    // 初始化WebRTC连接
    WebRTC_Init: function() {
        if (typeof SimpleWebRTC === 'undefined') {
            console.error("SimpleWebRTC not loaded");
            return false;
        }
        
        window.webRTCManager = new SimpleWebRTC({
            // 本地视频元素
            localVideoEl: 'localVideo',
            // 远程视频容器
            remoteVideosEl: 'remoteVideos',
            // 连接设置
            autoRequestMedia: false,
            // 使用公共STUN服务器
            connection: new RTCMultiConnection(),
        });
        
        // 配置连接
        webRTCManager.connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';
        webRTCManager.connection.session = {
            data: true, // 启用数据通道
            audio: false, // 不需要音频
            video: false  // 不需要视频
        };
        
        console.log("WebRTC Initialized");
        return true;
    },

    // 加入房间
    WebRTC_JoinRoom: function(roomIdPtr) {
        const roomId = UTF8ToString(roomIdPtr);
        
        if (!window.webRTCManager) {
            console.error("WebRTC not initialized");
            return false;
        }
        
        window.webRTCManager.joinRoom(roomId, function() {
            console.log("Joined room: " + roomId);
        });
        
        // 监听数据消息
        window.webRTCManager.connection.onmessage = function(event) {
            // 将接收到的消息传递给Unity
            if (window.unityInstance) {
                window.unityInstance.SendMessage('WebRTCNetworkManager', 'OnWebRTCMessage', event.data);
            }
        };
        
        return true;
    },

    // 创建房间（作为主机）
    WebRTC_CreateRoom: function(roomIdPtr) {
        const roomId = UTF8ToString(roomIdPtr);
        
        if (!window.webRTCManager) {
            console.error("WebRTC not initialized");
            return false;
        }
        
        window.webRTCManager.createRoom(roomId, function(roomId) {
            console.log("Created room: " + roomId);
        });
        
        // 监听数据消息
        window.webRTCManager.connection.onmessage = function(event) {
            // 将接收到的消息传递给Unity
            if (window.unityInstance) {
                window.unityInstance.SendMessage('WebRTCNetworkManager', 'OnWebRTCMessage', event.data);
            }
        };
        
        return true;
    },

    // 发送数据消息
    WebRTC_SendMessage: function(messagePtr) {
        const message = UTF8ToString(messagePtr);
        
        if (!window.webRTCManager) {
            console.error("WebRTC not initialized");
            return false;
        }
        
        window.webRTCManager.connection.send(message);
        return true;
    },

    // 检查是否已连接
    WebRTC_IsConnected: function() {
        if (!window.webRTCManager) {
            return false;
        }
        
        return window.webRTCManager.connection.isInitiator || 
               window.webRTCManager.getPeers().length > 0;
    },

    // 获取连接的对等方数量
    WebRTC_GetPeerCount: function() {
        if (!window.webRTCManager) {
            return 0;
        }
        
        return window.webRTCManager.getPeers().length;
    }
});