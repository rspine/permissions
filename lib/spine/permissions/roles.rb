module Spine
  module Permissions
    class Roles
      attr_reader :permissions

      def initialize
        @permissions = {}
      end

      def define(role)
        permissions[role] = Collection.new
      end

      def denied?(role, action, resource)
        !granted?(role, action, resource)
      end

      def granted?(role, action, resource)
        return false unless permissions[role]

        permissions[role].granted?(action, resource)
      end

      def configure(&block)
        instance_eval &block
      end
    end
  end
end
