require 'spec_helper'

module Chargify2
  describe Direct::SecureParameters do
    let(:client) { Client.new(valid_client_credentials) }

    it "raises an argument error if data is provided but it is not in hash format" do
      lambda {
        Direct::SecureParameters.new({'data' => 'string'}, client)
      }.should raise_error(ArgumentError)
    end

    it "raises an argument error if it could not get an api_id and secret from the passed client" do
      lambda {
        Direct::SecureParameters.new({}, Hashery::OpenCascade.new)
      }.should raise_error(ArgumentError)
    end

    describe "#timestamp?" do
      it "returns true when a timestamp is provided via a string hash key" do
        sp = Direct::SecureParameters.new({'timestamp' => '1234'}, client)
        sp.timestamp?.should be_true
      end

      it "returns true when a timestamp is provided via a symbol hash key" do
        sp = Direct::SecureParameters.new({:timestamp => '1234'}, client)
        sp.timestamp?.should be_true
      end

      it "returns false when a timestamp key/value is not provided" do
        sp = Direct::SecureParameters.new({}, client)
        sp.timestamp?.should be_false
      end

      it "returns false when a timestamp key is provided but the value is nil" do
        sp = Direct::SecureParameters.new({'timestamp' => nil}, client)
        sp.timestamp?.should be_false
      end

      it "returns false when a timestamp key is provided but the value is blank" do
        sp = Direct::SecureParameters.new({'timestamp' => ''}, client)
        sp.timestamp?.should be_false
      end
    end

    describe "#nonce?" do
      it "returns true when a nonce is provided via a string hash key" do
        sp = Direct::SecureParameters.new({'nonce' => '1234'}, client)
        sp.nonce?.should be_true
      end

      it "returns true when a nonce is provided via a symbol hash key" do
        sp = Direct::SecureParameters.new({:nonce => '1234'}, client)
        sp.nonce?.should be_true
      end

      it "returns false when a nonce key/value is not provided" do
        sp = Direct::SecureParameters.new({}, client)
        sp.nonce?.should be_false
      end

      it "returns false when a nonce key is provided but the value is nil" do
        sp = Direct::SecureParameters.new({'nonce' => nil}, client)
        sp.nonce?.should be_false
      end

      it "returns false when a nonce key is provided but the value is blank" do
        sp = Direct::SecureParameters.new({'nonce' => ''}, client)
        sp.nonce?.should be_false
      end
    end

    describe "#data?" do
      it "returns true when data is provided via a string hash key" do
        sp = Direct::SecureParameters.new({'data' => {'foo' => 'bar'}}, client)
        sp.data?.should be_true
      end

      it "returns true when data is provided via a symbol hash key" do
        sp = Direct::SecureParameters.new({:data => {'foo' => 'bar'}}, client)
        sp.data?.should be_true
      end

      it "returns false when a data key/value is not provided" do
        sp = Direct::SecureParameters.new({}, client)
        sp.data?.should be_false
      end

      it "returns false when a data key is provided but the value is nil" do
        sp = Direct::SecureParameters.new({'data' => nil}, client)
        sp.data?.should be_false
      end

      it "returns false when a data key is provided but the value is an empty hash" do
        sp = Direct::SecureParameters.new({'data' => {}}, client)
        sp.data?.should be_false
      end
    end

    describe "#encoded_data" do
      it "turns the data hash in to query string format" do
        sp = Direct::SecureParameters.new({'data' => {'one' => 'two', 'three' => 'four'}}, client)
        sp.encoded_data.should == "one=two&three=four"
      end

      it "turns a nested data hash in to nested query string format" do
        sp = Direct::SecureParameters.new({'data' => {'one' => {'two' => {'three' => 'four'}}, 'foo' => 'bar'}}, client)
        sp.encoded_data.should == "one[two][three]=four&foo=bar"
      end

      it "performs percent encoding on unsafe characters" do
        sp = Direct::SecureParameters.new({'data' => {'redirect_uri' => 'http://www.example.com', 'sentence' => 'Michael was here!'}}, client)
        sp.encoded_data.should == "redirect_uri=http%3A%2F%2Fwww.example.com&sentence=Michael+was+here%21"
      end
    end

    describe "#to_form_inputs" do
      context "with no timestamp, nonce, nor data" do
        it "outputs 2 hidden form inputs - one for the api_id and one for the signature" do
          sp = Direct::SecureParameters.new({}, client)
          form = Capybara::Node::Simple.new(sp.to_form_inputs)

          form.should have_selector("input", :count => 2)
          form.should have_selector("input[type='hidden'][name='secure[api_id]'][value='#{client.api_id}']", :count => 1)
          form.should have_selector("input[type='hidden'][name='secure[signature]'][value='#{sp.signature}']", :count => 1)
        end
      end

      context "with a timestamp" do
        it "outputs 3 hidden form inputs - one each for the api_id, timestamp, and signature" do
          sp = Direct::SecureParameters.new({'timestamp' => '1234'}, client)
          form = Capybara::Node::Simple.new(sp.to_form_inputs)

          form.should have_selector("input", :count => 3)
          form.should have_selector("input[type='hidden'][name='secure[api_id]'][value='#{client.api_id}']", :count => 1)
          form.should have_selector("input[type='hidden'][name='secure[timestamp]'][value='1234']", :count => 1)
          form.should have_selector("input[type='hidden'][name='secure[signature]'][value='#{sp.signature}']", :count => 1)
        end
      end

      context "with a nonce" do
        it "outputs 3 hidden form inputs - one each for the api_id, nonce, and signature" do
          sp = Direct::SecureParameters.new({'nonce' => '1234'}, client)
          form = Capybara::Node::Simple.new(sp.to_form_inputs)

          form.should have_selector("input", :count => 3)
          form.should have_selector("input[type='hidden'][name='secure[api_id]'][value='#{client.api_id}']", :count => 1)
          form.should have_selector("input[type='hidden'][name='secure[nonce]'][value='1234']", :count => 1)
          form.should have_selector("input[type='hidden'][name='secure[signature]'][value='#{sp.signature}']", :count => 1)
        end
      end

      context "with data" do
        it "outputs 3 hidden form inputs - one each for the api_id, nonce, and signature" do
          sp = Direct::SecureParameters.new({'data' => {'foo' => 'bar'}}, client)
          form = Capybara::Node::Simple.new(sp.to_form_inputs)

          form.should have_selector("input", :count => 3)
          form.should have_selector("input[type='hidden'][name='secure[api_id]'][value='#{client.api_id}']", :count => 1)
          form.should have_selector("input[type='hidden'][name='secure[data]'][value='foo=bar']", :count => 1)
          form.should have_selector("input[type='hidden'][name='secure[signature]'][value='#{sp.signature}']", :count => 1)
        end
      end

      context "with timestamp, nonce, and data" do
        it "outputs 3 hidden form inputs - one each for the api_id, nonce, and signature" do
          sp = Direct::SecureParameters.new({'timestamp' => '1234', 'nonce' => '5678', 'data' => {'foo' => 'bar'}}, client)
          form = Capybara::Node::Simple.new(sp.to_form_inputs)

          form.should have_selector("input", :count => 5)
          form.should have_selector("input[type='hidden'][name='secure[api_id]'][value='#{client.api_id}']", :count => 1)
          form.should have_selector("input[type='hidden'][name='secure[timestamp]'][value='1234']", :count => 1)
          form.should have_selector("input[type='hidden'][name='secure[nonce]'][value='5678']", :count => 1)
          form.should have_selector("input[type='hidden'][name='secure[data]'][value='foo=bar']", :count => 1)
          form.should have_selector("input[type='hidden'][name='secure[signature]'][value='#{sp.signature}']", :count => 1)
        end
      end
    end

    describe "#signature" do
      it "correctly calculates the signature by taking the HMAC-SHA1 hash of the concatenation of the api_id, timestamp, nonce, and encoded_data" do
        timestamp = '1234'
        nonce = '5678'
        data = {'one' => 'two', 'three' => {'four' => "http://www.example.com"}}
        sp = Direct::SecureParameters.new({'timestamp' => timestamp, 'nonce' => nonce, 'data' => data}, client)

        # Used the generator here: http://hash.online-convert.com/sha1-generator
        # ... with message: "1c016050-498a-012e-91b1-005056a216ab12345678one=two&three[four]=http%3A%2F%2Fwww.example.com"
        # ... and secret: "p5lxQ804MYtwZecFWNOT"
        # ... to get: "c57c36e619f575958221bcd4ce156c61347a3555"
        sp.signature.should == "c57c36e619f575958221bcd4ce156c61347a3555"
      end
    end
  end
end
