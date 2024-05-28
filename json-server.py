import json
from http.server import HTTPServer
from request_handler import HandleRequests, status

#import from views below

class JSONServer(HandleRequests):
    """Server class to handle incoming HTTP requests"""

    def do_GET(self):
        """Handle GET requests from a client"""
        # response_body = ""
        # url = self.parse_url(self.path)

        # else:
        return self.response("", status.HTTP_404_CLIENT_ERROR_RESOURCE_NOT_FOUND.value)
    
    def do_PUT(self):
         # Parse the URL and get the primary key
        url = self.parse_url(self.path)
        pk = url["pk"]

         # Get the request body JSON for the new data
        content_len = int(self.headers.get('content-length', 0))
        request_body = self.rfile.read(content_len)
        request_body = json.loads(request_body)
        
        #add else statement for no resource found

    def do_DELETE(self):
        """Handle DELETE requests from a client"""

        url = self.parse_url(self.path)
        pk = url["pk"]
        pass

    def do_POST(self):
        """Handle POST requests from a client"""
        
        # Parse the URL and get the primary key
        url = self.parse_url(self.path)

        content_len = int(self.headers.get('content-length', 0))
        request_body = self.rfile.read(content_len)
        request_body = json.loads(request_body)
        pass
    

#APPARENTLY NO ONE CARES ABOUT THIS
def main():
    host = ''
    port = 8088
    HTTPServer((host, port), JSONServer).serve_forever()

if __name__ == "__main__":
    main()
