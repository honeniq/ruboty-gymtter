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
          name = message.from_name
          count = increment(name)

          if anniversary?(count)
            count.to_s + '回目 えらい @' + name
          else
            'えらい @' + name
          end
        end

        def increment(name)
          data = message.robot.brain.data
          key = name + '.counter'

          data[key] ||= 0
          data[key] = data[key] + 1
        end

        def anniversary?(counter)
          counter % 10 == 0 ? true : false
        end
      end
    end
  end
end
