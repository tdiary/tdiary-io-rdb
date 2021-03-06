require 'spec_helper'

describe TDiary::IO::Rdb do
  it 'is_a TDiary::IO::Base' do
    expect(TDiary::IO::Rdb.new(DummyTDiary.new)).to be_a(TDiary::IO::Base)
  end

  describe "#save_cgi_conf and #load_cgi_conf" do
    let(:conf) { DummyConf.new }

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

  describe "#transaction" do
    let(:io) { TDiary::IO::Rdb.new(DummyTDiary.new) }
    let(:today) { Time.now.strftime( '%Y%m%d' ) }
    let(:diary) { DummyStyle.new('', "foo", "bar", '') }

    before do
      io.transaction( Time.now ) do |diaries|
        @diaries = diaries
        @diaries[today] = diary
        TDiary::TDiaryBase::DIRTY_DIARY
      end
    end

    subject { io.send(:db)[:diaries].filter(today).first }

    it "insert diary" do
      expect(subject).to_not be_nil
      expect(subject[:title]).to eq "foo"
      expect(subject[:body]).to eq "bar"
    end

    it "restore diary" do
      io.transaction( Time.now ) do |diaries|
        @diaries = diaries
        expect(@diaries[today].title).to eq "foo"
        expect(@diaries[today].to_src).to eq "bar"
        TDiary::TDiaryBase::DIRTY_DIARY
      end
    end

    context "update diary" do
      let(:diary2) { DummyStyle.new('' , "bar", "foo", '') }

      before do
        io.transaction( Time.now ) do |diaries|
          @diaries = diaries
          @diaries[today] = diary2
          TDiary::TDiaryBase::DIRTY_DIARY
        end
      end

      subject { io.send(:db)[:diaries].filter(today) }

      it "update contents of diary" do
        expect(subject).to_not be_nil
        expect(subject.count).to eq 1
        expect(subject.first[:title]).to eq "bar"
        expect(subject.first[:body]).to eq "foo"
      end
    end
  end
end
