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
          brain = message.robot.brain
          key = message.from_name + '.counter'

          brain.data[key] ||= 0
          brain.data[key] = brain.data[key] + 1
          if anniversary?(brain.data[key])
            brain.data[key].to_s + '回目 えらい @' + message.from_name
          else
            'えらい @' + message.from_name
          end
        end

        def anniversary?(counter)
          if counter % 10 == 0
            true
          else
            false
          end
        end
      end
    end
  end
end
