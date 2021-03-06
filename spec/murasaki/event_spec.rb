require './spec/spec_helper'

RSpec.describe EventLoop do
  describe EventLoop::Timer do
    it 'should get timed after 1 second' do
      answer = []
      timer = EventLoop::Timer.new(1) do
        answer << 1
        EventLoop.stop
      end
      EventLoop.add_timer(timer)
      answer << 0
      EventLoop.start
      expect(answer).to eq([0, 1])
    end
  end

  describe EventLoop do
    it 'should line up in queue if fd has been add multiple times' do
      io = IO.new(1)
      expect { 10.times do
        EventLoop.register(io, :r) do
          # Nothing
        end
      end }.to_not raise_error(RuntimeError)
    end
  end
end
