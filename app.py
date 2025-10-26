from http.server import BaseHTTPRequestHandler, HTTPServer

VERSION = "1.0.0"
HOST = '0.0.0.0'
PORT = 8000

class SimpleWebServer(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()

        html_content = f"""Version: {VERSION}
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
