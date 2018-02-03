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

          reply = 'えらい @' + name
          
          if anniversary?(count)
            reply.insert(0, "#{count}回目")
          end

          today = Date.today
          if HolidayJp.holiday?(today)
            holiday_name = HolidayJp.between(today, today).first.name
            reply.insert(0, holiday_name + 'なのに')
          end

          reply
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
