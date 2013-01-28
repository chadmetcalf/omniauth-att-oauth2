require 'spec_helper'
require 'omniauth-att-oauth2'

describe OmniAuth::Strategies::AttOauth2 do
  def app; lambda{|env| [200, {}, ["Hello."]]} end

  before :each do
    OmniAuth.config.test_mode = true
    @request = double('Request')
    @request.stub(:params) { {} }
    @request.stub(:cookies) { {} }
    @request.stub(:env) { {} }
  end

  after do
    OmniAuth.config.test_mode = false
  end

  subject do
    args = ['appid', 'secret', @options || {}].compact
    OmniAuth::Strategies::AttOauth2.new(app, *args).tap do |strategy|
      strategy.stub(:request) { @request }
    end
  end
  
  describe "custom arg" do
    xit "passes correct short code" do
      subject.options[:short_code].should eq('short_code')
    end    
  end

  describe '#client' do
    it 'has correct Att site' do
      subject.client.site.should eq('https://api.att.com')
    end

    it 'has correct authorize url' do
      subject.client.options[:authorize_url].should eq('/oauth/authorize')
    end

    it 'has correct token url' do
      subject.client.options[:token_url].should eq('/oauth/token.json')
    end
  end
  
  describe "#authorize" do
    it "builds the correct request_url" do
      
      
      # puts subject.authorize_user_json
      # subject.authorize_user_json.should include(insecure: "")
      
      # --request POST
      # --header "Accept: application/json"
      # --header "Authorization: Bearer 1c2939fd20f25a6e4d1dfe3801a9edc9"
      # --data "Address=tel%3A9139088480&Message='https://auth-api.att.com/user/login?client_id=#{}%26scope=SMS,TL'"
      
    end
  end

  describe '#callback_path' do
    it 'has the correct callback path' do
      subject.callback_path.should eq('/auth/att_oauth2/callback')
    end
  end

  describe '#authorize_params' do
    # %w(approval_prompt access_type state hd).each do |k|
    #   it "should set the #{k} authorize option dynamically in the request" do
    #     @options = {k.to_sym => ''}
    #     subject.stub(:request) { double('Request', {:params => { k => 'something' }, :env => {}}) }
    #     subject.authorize_params[k].should eq('something')
    #   end
    # end
    #   
    # describe 'scope' do
    #   it 'should expand scope shortcuts' do
    #     @options = { :authorize_options => [:scope], :scope => 'userinfo.email'}
    #     subject.authorize_params['scope'].should eq('https://www.googleapis.com/auth/userinfo.email')
    #   end
    # 
    #   it 'should leave full scopes as is' do
    #     @options = { :authorize_options => [:scope], :scope => 'https://www.googleapis.com/auth/userinfo.profile'}
    #     subject.authorize_params['scope'].should eq('https://www.googleapis.com/auth/userinfo.profile')
    #   end
    # 
    #   it 'should join scopes' do
    #     @options = { :authorize_options => [:scope], :scope => 'userinfo.profile,userinfo.email'}
    #     subject.authorize_params['scope'].should eq('https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email')
    #   end
    # 
    #   it 'should set default scope to userinfo.email,userinfo.profile' do
    #     @options = { :authorize_options => [:scope]}
    #     subject.authorize_params['scope'].should eq('https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile')
    #   end
    # 
    #   it 'should dynamically set the scope in the request' do
    #     @options = {:scope => 'http://example.com'}
    #     subject.stub(:request) { double('Request', {:params => { 'scope' => 'userinfo.email' }, :env => {}}) }
    #     subject.authorize_params['scope'].should eq('https://www.googleapis.com/auth/userinfo.email')
    #   end
    # end
    #   
    # describe 'approval_prompt' do
    #   it "should have the correct url" do
    #     subject.approval_prompt.should eq("https://api.att.com/rest/sms/2/messaging/outbox")
    #   end
    # end
    #   
    describe 'state' do
      it 'should set the state parameter' do
        @options = {:state => 'some_state'}
        subject.authorize_params['state'].should eq('some_state')
        subject.session['omniauth.state'].should eq('some_state')
      end
  
      it 'should set the omniauth.state dynamically' do
        subject.stub(:request) { double('Request', {:params => { 'state' => 'some_state' }, :env => {}}) }
        subject.authorize_params['state'].should eq('some_state')
        subject.session['omniauth.state'].should eq('some_state')
      end
    end
  
    # describe 'hd' do
    #   it 'should set the hd (hosted domain) parameter if present' do
    #     @options = {:hd => 'example.com'}
    #     subject.authorize_params['hd'].should eq('example.com')
    #   end
    # end
  end
  
  # describe 'raw info' do
  #   it 'should include raw_info in extras hash by default' do
  #     subject.stub(:raw_info) { { :foo => 'bar' } }
  #     subject.extra[:raw_info].should eq({ :foo => 'bar' })
  #   end
  # 
  #   it 'should not include raw_info in extras hash when skip_info is specified' do
  #     @options = { :skip_info => true }
  #     subject.extra.should_not have_key(:raw_info)
  #   end
  # end
  # 
  # describe 'populate auth hash url' do
  #   it 'should populate url map in auth hash if link present in raw_info' do
  #     subject.stub(:raw_info) { { 'name' => 'Foo', 'link' => 'https://plus.google.com/123456' } }
  #     subject.info[:urls]['Att'].should eq('https://plus.google.com/123456')
  #   end
  # 
  #   it 'should not populate url map in auth hash if no link present in raw_info' do
  #     subject.stub(:raw_info) { { 'name' => 'Foo' } }
  #     subject.info.should_not have_key(:urls)
  #   end
  # end

end