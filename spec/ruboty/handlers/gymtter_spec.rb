require 'spec_helper'
require 'ruboty/handlers/gymtter'
require 'ruboty/gymtter/actions/gym'

describe Ruboty::Handlers::Gymtter do
  context :gym do
    let(:robot) do
      Ruboty::Robot.new
    end

    describe '#gym' do
      let(:from) do
        "alice"
      end

      let(:to) do
        "#general"
      end

      let(:said) do
        "@ruboty gym"
      end

      let(:replied) do
        "えらい @alice"
      end

      it 'gym' do
        expect(robot).to receive(:say).with(
          body: replied,
          from: to,
          to: from,
          original: {
            body: said,
            from: from,
            robot: robot,
            to: to,
          },
        )
        robot.receive(body: said, from: from, to: to)
      end
    end
  end
end

