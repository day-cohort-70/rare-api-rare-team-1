import json
from http.server import HTTPServer
from request_handler import HandleRequests, status

#import from views below

from views import get_all_posts
from views import create_user, login_user
from views import get_single_post, addPost
from views import grabCategoryList, addCategory
from views import getTagList, addTag, deleteTag
from views import get_post_tags, get_all_post_tags, update_post_tags
from views import get_all_comments, get_post_comments, create_comment
from views import addPostTag



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
            else:
                response_body = get_all_posts(url)
                return self.response(response_body, status.HTTP_200_SUCCESS.value)
            
        elif url["requested_resource"] == "comments":
            if url['pk'] != 0:
                response_body = get_post_comments(url)
                return self.response(response_body, status.HTTP_200_SUCCESS.value)
            else:
                response_body = get_all_comments(url)
                return self.response(response_body, status.HTTP_200_SUCCESS.value)

        elif url["requested_resource"] == "category":
            if url["pk"] != 0:
                pass

            response_body = grabCategoryList()
            return self.response(response_body, status.HTTP_200_SUCCESS.value)
       
        elif resource == "tag":
            if url['pk'] != 0:
                pass
            else:
                response_body = getTagList()
                return self.response(response_body, status.HTTP_200_SUCCESS.value)
           
        elif resource == "posttag":
            if url['pk'] != 0:
                response_body = get_post_tags(url)
                return self.response(response_body, status.HTTP_200_SUCCESS.value)
            else:
                response_body = get_all_post_tags(url)
                return self.response(response_body, status.HTTP_200_SUCCESS.value)
           
        else:
            return self.response("", status.HTTP_404_CLIENT_ERROR_RESOURCE_NOT_FOUND.value)
       

    def do_PUT(self):
        url = self.parse_url(self.path)
        resource = url["requested_resource"]
        pk = url['pk']

        content_len = int(self.headers.get('content-length', 0))
        request_body = self.rfile.read(content_len)
        request_body = json.loads(request_body)
        
        if resource == "posttag":
            if url['pk'] != 0:
                successfully_updated = update_post_tags(pk, request_body)
                if successfully_updated:
                    return self.response("", status.HTTP_204_SUCCESS_NO_RESPONSE_BODY.value)
                else:
                    return self.response("Could not update tags", status.HTTP_404_CLIENT_ERROR_RESOURCE_NOT_FOUND.value)



    def do_DELETE(self):
        
        url = self.parse_url(self.path)
        pk = url["pk"]

        if url["requested_resource"] == "tag":
            if pk != 0:
                successfully_deleted = deleteTag(pk)
                if successfully_deleted:
                   return self.response("", status.HTTP_204_SUCCESS_NO_RESPONSE_BODY.value)
                
                return self.response("Requested resource not found", status.HTTP_404_CLIENT_ERROR_RESOURCE_NOT_FOUND.value)

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
            
        elif resource == 'register':
            successfully_registered = create_user(request_body)
            if successfully_registered:
                return self.response(successfully_registered, status.HTTP_201_SUCCESS_CREATED.value)
        
        elif resource == "comments":
            successfully_posted = create_comment(request_body)
            if successfully_posted:
                return self.response("", status.HTTP_201_SUCCESS_CREATED.value)
            else:
                return self.response("Unable to post comment", status.HTTP_400_CLIENT_ERROR_BAD_REQUEST_DATA.value)

        elif resource == "category":
            successfully_posted = addCategory(request_body)
            if successfully_posted:
                return self.response("", status.HTTP_201_SUCCESS_CREATED.value)
            else:
                return self.response("Requested resource not found", status.HTTP_404_CLIENT_ERROR_RESOURCE_NOT_FOUND.value)
        
        elif resource == "tag":
            successfully_posted = addTag(request_body)
            if successfully_posted:
                return self.response("", status.HTTP_201_SUCCESS_CREATED.value)
            return self.response("Requested Resource not found", status.HTTP_404_CLIENT_ERROR_RESOURCE_NOT_FOUND.value)

        elif resource == "posts":
            successfully_posted = addPost(request_body)
            #I changed this function to return the new post id or False
            if successfully_posted is not False:
                return self.response(successfully_posted, status.HTTP_201_SUCCESS_CREATED.value)  # Use 201 for created
            return self.response("Requested Resource not found", status.HTTP_404_CLIENT_ERROR_RESOURCE_NOT_FOUND.value)

        elif resource == "postTags":
            successfully_posted = addPostTag(request_body)
            if successfully_posted:
                    return self.response ("", status.HTTP_201_SUCCESS_CREATED.value)
            return self.response("Requested Resource not found", status.HTTP_404_CLIENT_ERROR_RESOURCE_NOT_FOUND.value)
#APPARENTLY NO ONE CARES ABOUT THIS
def main():
    host = ''
    port = 8088
    HTTPServer((host, port), JSONServer).serve_forever()

if __name__ == "__main__":
    main()
