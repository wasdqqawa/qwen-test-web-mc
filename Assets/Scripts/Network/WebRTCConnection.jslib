mergeInto(LibraryManager.library, {
    // 初始化WebRTC连接
    WebRTC_Init: function() {
        // 检查浏览器WebRTC支持
        if (!window.RTCPeerConnection || !window.RTCDataChannel) {
            console.error("WebRTC not supported by this browser");
            return false;
        }
        
        // 创建一个兼容Firefox和Chrome的WebRTC实现
        window.webRTCManager = {
            connection: null,
            isHost: false,
            roomId: null,
            peers: {},
            dataChannels: {},
            
            // 初始化连接
            init: function() {
                // 使用兼容性更好的配置
                const config = {
                    iceServers: [
                        { urls: "stun:stun.l.google.com:19302" },
                        { urls: "stun:stun1.l.google.com:19302" },
                        { urls: "stun:stun2.l.google.com:19302" }
                    ]
                };
                
                this.connection = new RTCPeerConnection(config);
                
                // 创建数据通道
                const dataChannel = this.connection.createDataChannel("data", {
                    ordered: true,
                    maxRetransmits: 10
                });
                
                this.setupDataChannel(dataChannel);
                this.setupConnectionEvents();
                
                return true;
            },
            
            // 设置数据通道事件
            setupDataChannel: function(channel) {
                const self = this;
                
                channel.onopen = function() {
                    console.log("Data channel opened");
                };
                
                channel.onclose = function() {
                    console.log("Data channel closed");
                };
                
                channel.onerror = function(err) {
                    console.error("Data channel error:", err);
                };
                
                channel.onmessage = function(event) {
                    // 将接收到的消息传递给Unity
                    if (window.unityInstance) {
                        window.unityInstance.SendMessage('WebRTCNetworkManager', 'OnWebRTCMessage', event.data);
                    }
                };
                
                this.dataChannels["default"] = channel;
            },
            
            // 设置连接事件
            setupConnectionEvents: function() {
                const self = this;
                
                this.connection.ondatachannel = function(event) {
                    const channel = event.channel;
                    self.setupDataChannel(channel);
                };
                
                this.connection.onicecandidate = function(event) {
                    if (event.candidate) {
                        // 发送ICE候选者
                        self.sendSignal({
                            type: "ice-candidate",
                            candidate: event.candidate
                        });
                    }
                };
                
                this.connection.onconnectionstatechange = function() {
                    console.log("Connection state:", self.connection.connectionState);
                };
                
                this.connection.oniceconnectionstatechange = function() {
                    console.log("ICE connection state:", self.connection.iceConnectionState);
                };
            },
            
            // 发送信号消息
            sendSignal: function(message) {
                // 这里需要实现信令服务器通信
                // 暂时使用本地模拟
                console.log("Signal message:", message);
            },
            
            // 创建房间
            createRoom: function(roomId) {
                this.isHost = true;
                this.roomId = roomId;
                console.log("Created room: " + roomId);
                return true;
            },
            
            // 加入房间
            joinRoom: function(roomId) {
                this.isHost = false;
                this.roomId = roomId;
                console.log("Joined room: " + roomId);
                return true;
            },
            
            // 发送消息
            sendMessage: function(message) {
                const channel = this.dataChannels["default"];
                if (channel && channel.readyState === "open") {
                    channel.send(message);
                    return true;
                }
                console.error("Data channel not open");
                return false;
            },
            
            // 检查连接状态
            isConnected: function() {
                return this.connection && 
                       (this.connection.connectionState === "connected" || 
                        this.connection.connectionState === "connecting");
            },
            
            // 获取对等方数量
            getPeerCount: function() {
                return Object.keys(this.peers).length;
            }
        };
        
        // 初始化WebRTC管理器
        if (window.webRTCManager.init()) {
            console.log("WebRTC Initialized");
            return true;
        }
        
        return false;
    },

    // 加入房间
    WebRTC_JoinRoom: function(roomIdPtr) {
        const roomId = UTF8ToString(roomIdPtr);
        
        if (!window.webRTCManager) {
            console.error("WebRTC not initialized");
            return false;
        }
        
        return window.webRTCManager.joinRoom(roomId);
    },

    // 创建房间（作为主机）
    WebRTC_CreateRoom: function(roomIdPtr) {
        const roomId = UTF8ToString(roomIdPtr);
        
        if (!window.webRTCManager) {
            console.error("WebRTC not initialized");
            return false;
        }
        
        return window.webRTCManager.createRoom(roomId);
    },

    // 发送数据消息
    WebRTC_SendMessage: function(messagePtr) {
        const message = UTF8ToString(messagePtr);
        
        if (!window.webRTCManager) {
            console.error("WebRTC not initialized");
            return false;
        }
        
        return window.webRTCManager.sendMessage(message);
    },

    // 检查是否已连接
    WebRTC_IsConnected: function() {
        if (!window.webRTCManager) {
            return false;
        }
        
        return window.webRTCManager.isConnected();
    },

    // 获取连接的对等方数量
    WebRTC_GetPeerCount: function() {
        if (!window.webRTCManager) {
            return 0;
        }
        
        return window.webRTCManager.getPeerCount();
    }
});