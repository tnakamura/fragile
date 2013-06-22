# coding: utf-8
require "spec_helper"
require "fragile/plugin/im_kayac_output"

describe Fragile::Plugin::ImKayacOutput do
  let :output do
    described_class.new(
      :handler  => 'handler',
      :username => 'username',
      :password => 'password',
      :secret_key => 'secret_key',
    )
  end

  it '@base_url が正しく設定されているべき' do
    expect(output.instance_eval { @base_url }).to eq 'http://im.kayac.com/api/post/'
  end

  it '@handler が正しく設定されているべき' do
    expect(output.instance_eval { @handler }).to eq 'handler'
  end

  it '@username が正しく設定されているべき' do
    expect(output.instance_eval { @username }).to eq 'username'
  end

  it '@password が正しく設定されているべき' do
    expect(output.instance_eval { @password }).to eq 'password'
  end

  it '@secret_key が正しく設定されているべき' do
    expect(output.instance_eval { @secret_key }).to eq 'secret_key'
  end

  it '#call を持つべき' do
    expect(output).to respond_to :call
  end

  context '#callが引数なしで実行されたとき' do
    it '#send_im_kayac が実行されないべき' do
      output.should_not_receive(:send_im_kayac)
      output.call
    end
  end

  context '#callが引数ありで実行されたとき' do
    it '#send_im_kayac が実行されるべき' do
      output.should_receive(:send_im_kayac)
      output.call(['a'])
    end
  end

end

