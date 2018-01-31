require 'spec_helper'
require 'ruboty/handlers/gymtter'
require 'ruboty/gymtter/actions/gym'

describe Ruboty::Handlers::Gymtter do
  context :gym do
    let(:robot) do
      Ruboty::Robot.new
    end

    shared_context 'alice to ruboty' do
      let(:message) do 
        {
         body: 'えらい @alice',
          from: '#general',
          to: 'alice',
           original: {
             body: '@ruboty gym',
             from: 'alice',
             robot: robot,
             to: '#general',
           },
        }
      end
    end
  
    describe '#gym normal pattern' do
      describe 'gym' do
        include_context 'alice to ruboty'
        it 'gymと言われたらえらいと返す' do
          message[:original][:body] = '@ruboty gym'
          expect(robot).to receive(:say).with(message)
          robot.receive(body: "@ruboty gym", from: 'alice', to: '#general')
        end
      end
  
      describe 'ジム' do
        include_context 'alice to ruboty'
        it 'ジムと言われたらえらいと返す' do
          message[:original][:body] = '@ruboty ジム'
          expect(robot).to receive(:say).with(message)
          robot.receive(body: '@ruboty ジム', from: 'alice', to: '#general')
        end
      end
  
      describe '昨日ジム行ってきた' do
        include_context 'alice to ruboty'
        it '前後に他の言葉が入ってても、ジムと言われたらえらいと返す' do
          message[:original][:body] = '@ruboty 昨日ジム行ってきた'
          expect(robot).to receive(:say).with(message)
          robot.receive(body: '@ruboty 昨日ジム行ってきた', from: 'alice', to: '#general')
        end
      end
    end
  
    describe '#gym anniversary pattern' do
      describe '10の倍数だったら「○回目 えらい」と返す' do
        include_context 'alice to ruboty'

        it '10回目 えらい' do
          robot.brain.data['alice.counter'] = 9
          
          message[:original][:body] = '@ruboty gym'
          message[:body] = '10回目 えらい @alice'
          expect(robot).to receive(:say).with(message)
          robot.receive(body: "@ruboty gym", from: 'alice', to: '#general')
        end

        it '70回目 えらい' do
          robot.brain.data['alice.counter'] = 69
          
          message[:original][:body] = '@ruboty gym'
          message[:body] = '70回目 えらい @alice'
          expect(robot).to receive(:say).with(message)
          robot.receive(body: "@ruboty gym", from: 'alice', to: '#general')
        end
      end
    end
  end
end
