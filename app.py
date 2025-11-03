from http.server import BaseHTTPRequestHandler, HTTPServer
import socket  # socket 模組是必要的

VERSION = "1.3" # 你的 log 顯示版本是 1.0
HOST = '0.0.0.0'
PORT = 8000

def get_container_ip():
    """
    使用 'connect to external' 技巧取得本機 IP。
    這個方法更可靠，不需要依賴 /etc/hosts。
    """
    s = None
    try:
        # 1. 建立一個 UDP socket (SOCK_DGRAM)
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        
        # 2. 嘗試 "連接" 到一個外部、可路由的 IP (不需要真的連上)
        #    這裡使用 Google 的 DNS 伺服器 8.8.8.8
        s.connect(("8.8.8.8", 80)) 
        
        # 3. 取得 OS 為這個 "連接" 所分配的本機 IP
        ip_address = s.getsockname()[0] 
        return ip_address
    
    except socket.error:
        # 如果連 8.8.8.8 都不通 (例如離線環境)，才回傳錯誤
        return "無法取得 IP (connect_trick failed)"
    finally:
        # 4. 確保關閉 socket
        if s:
            s.close()

class SimpleWebServer(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html; charset=utf-8")
        self.end_headers()

        # 呼叫新的函式來取得 IP
        container_ip = get_container_ip()

        html_content = f"""
 Container IP: {container_ip}, Version: {VERSION} 
"""
        self.wfile.write(bytes(html_content, "utf-8"))

if __name__ == "__main__":
    webServer = HTTPServer((HOST, PORT), SimpleWebServer)
    print(f"Web server started on http://{HOST}:{PORT}")
    try:
        webServer.serve_forever()
    except KeyboardInterrupt:
        pass
    webServer.server_close()
    print("Server stopped.")