module Ruboty
  module Gymtter
    module Actions
      class Gym < Ruboty::Actions::Base
        def call
          message.reply(gym)
        rescue => e
          message.reply(e.message)
        end

        private
        def gym
          #message.from.to_s + 'えらい'
          '@' + message.from_name + ' えらい'
        end
      end
    end
  end
end
