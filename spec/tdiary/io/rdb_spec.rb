require 'spec_helper'

describe TDiary::IO::Rdb do
  it 'is_a TDiary::IO::Base' do
    expect { TDiary::IO::Rdb.is_a?(TDiary::IO::Base) }.to be_true
  end

  describe "#save_cgi_conf and #load_cgi_conf" do
    let(:conf) { Dummy.new }

    it { expect(TDiary::IO::Rdb.load_cgi_conf(conf)).to be_empty }

    context "given body" do
      before do
        TDiary::IO::Rdb.save_cgi_conf(conf, 'foo')
      end

      it { expect(TDiary::IO::Rdb.load_cgi_conf(conf)).to eq 'foo' }

      context "update" do
        before do
          TDiary::IO::Rdb.save_cgi_conf(conf, 'bar')
        end
        it { expect(TDiary::IO::Rdb.load_cgi_conf(conf)).to eq 'bar' }
      end
    end
  end
end
