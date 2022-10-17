# This code is mostly selfdocumented 
from http.server import HTTPServer, BaseHTTPRequestHandler
import json, socket, geocoder


class Proc(BaseHTTPRequestHandler):
    # Returns a formated page from BaseHTTPRequestHandler with default metadata while wfile.write apends the body of the html.
    def do_GET(self):
        # To let the browser know what type of information to expect embeding into the application layer. 
        self.send_header("Content-type", "application/json") 
        client_ip = socket.gethostbyname(socket.gethostname())
        geoip = geocoder.ip(client_ip)
        city_of_ip = geoip.city
        state_of_ip = geoip.state
        
        response_status = json.dumps({"result": "success"}) 
        response_ip = json.dumps({"ip": client_ip, "city": city_of_ip, "state": state_of_ip}, sort_keys=False, indent=4)
        response_else = "Try /status or /ip as endpoints!"

        if self.path == '/status':
            # Response used to troubleshoot
            self.send_response(200)
            self.end_headers()
            self.wfile.write(bytes(response_status, 'utf-8'))
        elif self.path == '/ip':
            self.send_response(200)
            self.end_headers()
            self.wfile.write(bytes(response_ip, 'utf-8'))
        # To help redirect new users to the right endpoints ~ in real-world, generally automatically redrict users to the correct URI.
        else: 
            self.send_response(404)
            self.end_headers()
            self.wfile.write(bytes(response_else, 'utf-8'))

pythonserver = HTTPServer(('0.0.0.0', 80), Proc)
print("Server is successfully running... ")
pythonserver.serve_forever()

# Exceptionally dry code just for you >__<
