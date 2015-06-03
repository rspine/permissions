module Spine
  module Permissions
    module Deny
      extend self

      def granted?
        false
      end

      def denied?
        true
      end
    end
  end
end
