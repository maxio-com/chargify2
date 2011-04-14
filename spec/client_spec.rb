require 'spec_helper'

describe Chargify2::Client do
  it "holds an api_id when passed to .new in the 'api_id' key" do
    client = Chargify2::Client.new('api_id' => "myid")
    client.api_id.should == 'myid'
  end

  it "holds an api_id when passed to .new in the :api_id key" do
    client = Chargify2::Client.new(:api_id => "myid")
    client.api_id.should == 'myid'
  end

  it "holds an api_password when passed to .new in the 'api_password' key" do
    client = Chargify2::Client.new('api_password' => "mypass")
    client.api_password.should == 'mypass'
  end

  it "holds an api_password when passed to .new in the :api_password key" do
    client = Chargify2::Client.new(:api_password => "mypass")
    client.api_password.should == 'mypass'
  end

  it "holds an api_secret when passed to .new in the 'api_secret' key" do
    client = Chargify2::Client.new('api_secret' => "mysecret")
    client.api_secret.should == 'mysecret'
  end

  it "holds an api_secret when passed to .new in the :api_secret key" do
    client = Chargify2::Client.new(:api_secret => "mysecret")
    client.api_secret.should == 'mysecret'
  end
end