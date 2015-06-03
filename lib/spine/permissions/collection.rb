module Spine
  module Permissions
    class Collection
      def initialize
        @registered = { all: { all: default_permission } }
      end

      def grant(action, resource)
        add(Grant, action, resource)
        self
      end

      def deny(action, resource)
        add(Deny, action, resource)
        self
      end

      def granted?(action, resource)
        permission(action, resource).granted?
      end

      def denied?(action, resource)
        permission(action, resource).denied?
      end

      def permission(action, resource)
        resource_permission = registered[resource] || registered[:all]
        resource_permission[action] || resource_permission[:all]
      end

      def default_permission
        Deny
      end

      private

      attr_reader :registered

      def add(permission, action, resource)
        if resource == :all
          add_to_all_resources(permission, action)
        elsif action == :all
          add_to_all_actions(permission, resource)
        else
          add_to_resource(permission, action, resource)
        end
      end

      def add_to_all_resources(permission, action)
        registered.keys.each do |resource|
          add_to_all_actions(permission, resource) if action == :all
          registered[resource][action] = permission
        end
      end

      def add_to_all_actions(permission, resource)
        permissions = registered[resource]
        permissions.keys.each do |action|
          permissions[action] = permission
        end
      end

      def add_to_resource(permission, action, resource)
        registered[resource] ||= registered[:all].dup
        registered[resource][action] = permission
      end
    end
  end
end
