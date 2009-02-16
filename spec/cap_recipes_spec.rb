require File.expand_path("spec_helper", File.dirname(__FILE__))

describe 'loading everything' do
  def run_cap(folder,task)
    folder = File.join(File.dirname(__FILE__),'cap',folder)
    `cd #{folder} && #{task}`
  end

  it "finds all tasks" do
    tasks = run_cap 'all', 'cap -T'
    tasks.split("\n").size.should >= 20
  end
end