require 'rails_helper'

RSpec.describe Post, type: :model do
  include ActiveJob::TestHelper

  describe 'associtations' do
    it { should belong_to :user }
    it { should belong_to :open_graph_cache }
  end

  describe '.open_graph_cache' do
    before do
      @noua_url = "https://noua.io"
      @post_text = "#{@noua_url} is an awesome pewpewz"
    end

    it 'should queue GatherOpenGraphDataJob if links is included' do
      post = Fabricate.build(:post, text: @post_text)
      #expect(GatherOpenGraphDataJob).to receive(:perform_later).with(instance_of(Fixnum), instance_of(String))
      GatherOpenGraphDataJob.new.expects(:perform_later).with(instance_of(Fixnum), instance_of(String))
      post.save
    end

    describe '#contains_open_graph_url_in_text?' do
      it 'returns the opengraph url' do
        post = Fabricate.build(:post, text: @post_text)
        expect(post.contains_open_graph_url_in_text?).not_to be_nil
        expect(post.open_graph_url).to eq(@noua_url)
      end
    end
  end
end
