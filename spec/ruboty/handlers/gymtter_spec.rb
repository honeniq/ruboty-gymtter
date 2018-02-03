require 'spec_helper'
require 'ruboty/handlers/gymtter'
require 'ruboty/gymtter/actions/gym'

describe Ruboty::Handlers::Gymtter do
  context :gym do
    let(:robot) do
      Ruboty::Robot.new
    end

    shared_examples 'conversation' do 
      | said='@ruboty gym', expected='えらい @alice', count=0 |

      let(:message) do 
        {
         body: expected,
          from: '#general',
          to: 'alice',
           original: {
             body: said,
             from: 'alice',
             robot: robot,
             to: '#general',
           },
        }
      end
      it "'#{said}'と言われたら、'#{expected}'と応える" do 
        robot.brain.data['alice.counter'] = count
        expect(robot).to receive(:say).with(message)
        robot.receive(body: said, from: 'alice', to: '#general')
      end
    end
    
    describe '#gym' do
      describe '通常パターン(gym)' do
        include_examples 'conversation' , said='@ruboty gym', expected='えらい @alice'
      end

      describe '通常パターン(ジム)' do
        include_examples 'conversation' , said='@ruboty ジム', expected='えらい @alice'
      end

      describe '前後に他の言葉が入っていても反応する' do
        include_examples 'conversation' , said='@ruboty 昨日ジム行ってきた',
          expected='えらい @alice'
      end

      describe '記念パターン' do
        describe '10の倍数のときは記念パターン' do
          include_examples 'conversation' , said='@ruboty gym',
            expected="10回目 えらい @alice", count=9
        end

        describe '10の倍数のときは記念パターン' do
          include_examples 'conversation' , said='@ruboty gym',
            expected="70回目 えらい @alice", count=69
        end

        describe '普通の数字のときはいつも通りの返事' do
          include_examples 'conversation' , said='@ruboty gym',
            expected="えらい @alice", count=10
        end
      end
    end

    describe '#count' do
      describe '累計回数を教えてくれる(13回行ってる状態)' do
        include_examples 'conversation' , said='@ruboty count',
          expected='13回ジムに行っています @alice', count=13
      end

      describe '行ったことがないときは回数を返さない' do
        include_examples 'conversation' , said='@ruboty count',
          expected='まだジムに行ったことがありません @alice', count=0
      end
    end
  end
end
