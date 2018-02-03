module Ruboty
  module Gymtter
    module Actions
      class Count < Ruboty::Actions::Base
        def call
          message.reply(count)
        rescue => e
          message.reply(e.message)
        end

        private
        def count
          brain = message.robot.brain
          key = message.from_name + '.counter'

          brain.data[key] ||= 0
          if brain.data[key] == 0
            'まだジムに行ったことがありません @' + message.from_name
          else
            brain.data[key].to_s + '回ジムに行っています @' + message.from_name
          end
        end
      end
    end
  end
end
