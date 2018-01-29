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

  describe '#gym' do
    describe 'keyword gym' do
      include_context 'alice to ruboty'
      it 'gym' do
        expect(robot).to receive(:say).with(message)
        robot.receive(body: "@ruboty gym", from: 'alice', to: '#general')
      end
    end

    describe 'keyword ジム' do
      include_context 'alice to ruboty'
      it 'gym2' do
        message[:original][:body] = '@ruboty ジム'
        expect(robot).to receive(:say).with(message)
        robot.receive(body: '@ruboty ジム', from: 'alice', to: '#general')
      end
    end
  end
end
end
