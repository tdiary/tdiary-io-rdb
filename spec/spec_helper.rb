$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'tdiary/comment_manager'
require 'tdiary/referer_manager'
require 'tdiary/cache/file'
require 'tdiary/io/rdb'

class Dummy
  def database_url
    'sqlite://./tdiary_test.db'
  end
end

RSpec.configure do |c|
  c.after(:suite) do
    FileUtils.rm_rf File.expand_path('../../tdiary_test.db', __FILE__)
  end
end
