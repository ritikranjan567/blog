class ApplicationController
    attr_accessor :request, :client
    
    def initialize(client, request)
        @client = client
        @request = request
    end

    def respond(body: 'This is default body', type: 'text/html', status_code: '200')
        puts request
        client.print "HTTP/1.1 #{status_code}\r\n"
        client.print "Content-Type: #{type}\r\n"
        client.print "\r\n"
        client.print "#{body}\r\n"
    end
end