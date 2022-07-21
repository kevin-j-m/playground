require "spec_helper"
require "base64"

RSpec.describe "Symmetric Spies" do
  class Cipher
    def self.encode(message)
      sleep(5) # EXPENSIVE COMPUTATION
      Base64.encode64(message)
    end

    def self.decode(message)
      return nil unless message

      sleep(7) # COMPLICATED STUFF
      Base64.decode64(message)
    end
  end

  class Agent
    def pass_secret(message, to:)
      to.receive_secret(Cipher.encode(message))
    end
  end

  class Mole
    attr_reader :messages

    def initialize
      @messages = []
    end

    def receive_secret(message)
      messages << Cipher.decode(message)
    end

    def last_message
      @messages.last
    end
  end

  it "encodes the message" do
    expect(Cipher).to receive(:encode).with("hello")

    spy = Agent.new
    mole = Mole.new

    spy.pass_secret("hello", to: mole)
  end

  it "also encodes the message" do
    allow(Cipher).to receive(:encode)

    spy = Agent.new
    mole = Mole.new

    spy.pass_secret("hello", to: mole)

    expect(Cipher).to have_received(:encode).with("hello")
  end

  it "sends the encoded message to the receiver" do
    spy = Agent.new
    mole = Mole.new

    expect(Cipher).to receive(:encode).with("hello").and_return("mystery")
    expect(mole).to receive(:receive_secret).with("mystery")

    spy.pass_secret("hello", to: mole)
  end

  it "also sends the encoded message to the receiver" do
    spy = Agent.new
    mole = Mole.new

    allow(Cipher).to receive(:encode).with("hello").and_return("mystery")
    allow(mole).to receive(:receive_secret)

    spy.pass_secret("hello", to: mole)

    expect(mole).to have_received(:receive_secret).with("mystery")
  end

  it "decodes the message" do
    mole = Mole.new

    allow(Cipher).to receive(:decode).with("mystery").and_return("hello")

    mole.receive_secret("mystery")

    expect(mole.last_message).to eq "hello"
  end
end
