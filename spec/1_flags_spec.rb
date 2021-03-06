require './lib/triage/flags'
require './lib/triage/common'

describe Flags, ' Object' do

  let(:test_flags) do
    temp = {}
    0.upto(7) {|i| temp["flag_#{i+1}".to_sym]=2**i}
    temp
  end

  subject(:flags) {Flags.new(0,'testing')}

  context "when created" do
    it 'is instantiated without errors' do
      expect(flags).to exist
    end
    it 'can load test values' do
    expect(flags.class.flags).to eq(test_flags)
    end
    it 'will not overwrite class instance flags variable' do
      expect(Flags.new(0,['new']).class.flags).to eq(test_flags)
    end
  end
  
  context 'when requesting flags' do
    it 'will return the state of a flag' do
      expect(flags.flag?(:flag_1)).to eq(false)
    end
  end

  context 'when setting flag values' do
    it 'can set a flag value to true' do
      flags.set_flag(:flag_1, true)
      expect(flags.flag?(:flag_1)).to eq(true)
    end
    it 'can set a flag value to false' do
      flags.set_flag(:flag_1, false)
      expect(flags.flag?(:flag_1)).to eq(false)
    end
    it 'will throw an error if invalid value is passed' do
      expect{flags.set_flag(:flag_1,'asf')}.to raise_error(InvalidInput)
    end
  end

  context 'when requesting all active flags' do
    it 'will return a list of all active flags' do
      flags.set_flag(:flag_1, true)
      flags.set_flag(:flag_3, true)
      flags.set_flag(:flag_8, true)
      expect(flags.active_flags).to eq([:flag_1, :flag_3, :flag_8])
    end
  end
end