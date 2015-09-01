require "spec_helper"

RSpec.describe "css frameworks" do
  before do
    drop_dummy_database
    remove_project_directory
  end

  it "suspends a project for Bootstrap" do
    run_suspenders("--css-framework=bootstrap-sass")

    expect("bootstrap-sass").to be_in_the_gemfile
  end
end
