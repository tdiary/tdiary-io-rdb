require 'spec_helper'

describe TDiary::IO::Rdb do
  it 'is_a TDiary::IO::Base' do
    expect { TDiary::IO::Rdb.is_a?(TDiary::IO::Base) }.to be_true
  end
end
