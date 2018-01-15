require "ruboty/gymtter/actions/gym"

module Ruboty
  module Handlers
    # A Ruboty Handler for Gymtter
    class Gymtter < Base
      on /gym/, name: 'gym', description: 'ジムと言われたらえらいと応える'
      on /ジム/, name: 'gym', description: 'ジムと言われたらえらいと応える'


      def gym(message)
        Ruboty::Gymtter::Actions::Gym.new(message).call
      end

    end
  end
end
