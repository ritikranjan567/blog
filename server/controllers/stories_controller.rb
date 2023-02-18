class StoriesController < ApplicationController
    def index
        respond(
            body: "You are seeing the all the stories of the blog",
            type: 'text/html',
            status_code: 200
        )
    end
end