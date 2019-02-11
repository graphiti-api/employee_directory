require 'rails_helper'

RSpec.describe "posts#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/posts/#{post.id}", payload
  end

  describe 'basic update' do
    let!(:post) { create(:post) }

    let(:payload) do
      {
        data: {
          id: post.id.to_s,
          type: 'posts',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(PostResource).to receive(:find).and_call_original
      expect {
        make_request
      }.to change { post.reload.attributes }
      expect(response.status).to eq(200)
    end
  end
end
