require "ruboty/gymtter/actions/gym"
require "ruboty/gymtter/actions/count"

module Ruboty
  module Handlers
    # A Ruboty Handler for Gymtter
    class Gymtter < Base
      on /.*?gym/, name: 'gym', description: 'ジムと言われたらえらいと応える'
      on /.*?ジム/, name: 'gym', description: 'ジムと言われたらえらいと応える'
      on /count/, name: 'count', description: 'これまでの通算回数を返す'

      def gym(message)
        Ruboty::Gymtter::Actions::Gym.new(message).call
      end

      def count(message)
        Ruboty::Gymtter::Actions::Count.new(message).call
      end
    end
  end
end
