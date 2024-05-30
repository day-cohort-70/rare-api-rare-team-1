import json
from http.server import HTTPServer
from request_handler import HandleRequests, status

#import from views below

from views import create_user, login_user
from views import get_single_post

class JSONServer(HandleRequests):
    """Server class to handle incoming HTTP requests"""

    def do_GET(self):

        response_body = ""
        url = self.parse_url(self.path)
        resource = url["requested_resource"]

        if resource == "posts":
            if url['pk'] != 0:
                response_body = get_single_post(url)
                return self.response(response_body, status.HTTP_200_SUCCESS.value)


    def do_PUT(self):
        pass

    def do_DELETE(self):
        pass

    def do_POST(self):
        # Parse the URL and get the primary key
        url = self.parse_url(self.path)
        resource = url["requested_resource"]

         # Get the request body JSON for the new data
        content_len = int(self.headers.get('content-length', 0))
        request_body = self.rfile.read(content_len)
        request_body = json.loads(request_body)
        
        #Handles initial login
        if resource == "login":
            verify_user = login_user(request_body)
            if 'true' in verify_user:
                return self.response(verify_user, status.HTTP_200_SUCCESS.value)
            else: 
                return self.response("", status.HTTP_400_CLIENT_ERROR_BAD_REQUEST_DATA)
            
        # Handles user registration
        if resource == 'register':
            successfully_registered = create_user(request_body)
            if successfully_registered:
                return self.response(successfully_registered, status.HTTP_201_SUCCESS_CREATED.value)
        
    

#APPARENTLY NO ONE CARES ABOUT THIS
def main():
    host = ''
    port = 8088
    HTTPServer((host, port), JSONServer).serve_forever()

if __name__ == "__main__":
    main()
