module Routing

    def self.included base
        base.extend ClassMethods
        base.include InstanceMethods
    end

    module ClassMethods
        def require_all
            puts '-----------Here-------------'
            Dir['./controllers/*.rb'].each do |file|
                require file
            end
        end
    end

    module InstanceMethods
        def parser(req_string)
            parts = req_string.split(' ')
            type = parts[0]
            url = parts[1]
            {
                type: type,
                url: url
            }    
        end
    end

    class RouteMapping
        include Routing
        attr_reader :server, :routes
        require_all

        def initialize(server, routes)
            @server = server
            @routes = routes
        end

        def observe_and_map
            while client = server.accept
                req_string = client.gets
                puts req_string
                @parsed_route = parser(req_string)
                puts @parsed_route
                controller_info = get_controller_info
                p controller_info
                controller_info[:controller].new(client, req_string).send(controller_info[:action])
            end
        end

        def get_controller_info
            typed_routes = routes[@parsed_route[:type]]
            controller_infos = typed_routes[@parsed_route[:url]].split('::')
            controller = Object.const_get controller_infos[0]
            action = controller_infos[1]
            {
                controller: controller,
                action: action
            }
        end
    end
end