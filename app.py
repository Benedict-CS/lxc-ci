from http.server import BaseHTTPRequestHandler, HTTPServer
import socket 

VERSION = "1.0.1"
HOST = '0.0.0.0'
PORT = 8000

def get_container_ip():

    s = None
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        
        s.connect(("8.8.8.8", 80)) 
        
        ip_address = s.getsockname()[0] 
        return ip_address
    
    except socket.error:
        return "無法取得 IP (connect_trick failed)"
    finally:
        if s:
            s.close()

class SimpleWebServer(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html; charset=utf-8")
        self.end_headers()

        container_ip = get_container_ip()

        html_content = f""" Container IP: {container_ip}, Version: {VERSION} 
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