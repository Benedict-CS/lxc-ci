from http.server import BaseHTTPRequestHandler, HTTPServer
import socket  # 1. 匯入 socket 模組

VERSION = "1.0"
HOST = '0.0.0.0'
PORT = 8000

def get_container_ip():
    """取得 container 的 IP 位址"""
    try:
        # 取得主機名稱 (在 container 中通常是一個 ID，例如 'a1b2c3d4')
        hostname = socket.gethostname()
        # 透過主機名稱解析出 IP 位址
        ip_address = socket.gethostbyname(hostname)
        return ip_address
    except socket.error:
        return "無法取得 IP"

class SimpleWebServer(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html; charset=utf-8") # 加上 charset=utf-8 避免亂碼
        self.end_headers()

        # 2. 呼叫函式取得 IP
        container_ip = get_container_ip()

        # 3. 將 IP 加入到 HTML 中
        html_content = f"""
<html>
<head><title>Server Info</title></head>
<body>
    <h1>Container 資訊</h1>
    <p>Version: {VERSION}</p>
    <p>Container IP: {container_ip}</p>
</body>
</html>
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