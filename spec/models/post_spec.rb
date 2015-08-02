# == Schema Information
#
# Table name: posts
#
#  id                  :uuid             not null, primary key
#  user_id             :uuid             not null
#  public              :boolean          default(FALSE), not null
#  text                :text
#  likes_count         :integer          default(0)
#  comments_count      :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  open_graph_cache_id :integer
#  from_user_id        :uuid
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Post, type: :model do
  include ActiveJob::TestHelper

  before :all do
    WebMock.disable_net_connect! allow_localhost: true
  end

  after :all do
    WebMock.disable_net_connect!
  end

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
