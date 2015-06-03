module Spine
  module Permissions
    module Grant
      extend self

      def granted?
        true
      end

      def denied?
        false
      end
    end
  end
end
